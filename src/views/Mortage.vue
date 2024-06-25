<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-menu-button color="primary"></ion-menu-button>
        </ion-buttons>
        <ion-title>Amortizacion</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">

      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Amortizacion</ion-title>
        </ion-toolbar>
      </ion-header>

      <ion-grid class="ion-justify-content-center">
        <ion-card>
          <ion-card-content>
            <!--<ion-col size="12" size-md="8" size-lg="6" size-xl="4">
          EN VEZ DE USAR ESTO, CREA TUS PROPIAR REGLAS "MEDIA" EN CSS -->
            <ion-row>
              <ion-col>
                <h1>Formulario</h1>
              </ion-col>
            </ion-row>

            <form @submit.prevent="handleSubmit">
              <ion-row>
                <ion-col>
                  <ion-input v-model="form_data.loan" fill="outline" label-placement="floating" label="Deuda"
                    type="number" step="0.01">
                  </ion-input>
                </ion-col>
              </ion-row>

              <ion-row>
                <ion-col>
                  <ion-input v-model="form_data.quotas_to_pay" fill="outline" label-placement="floating"
                    label="Numero de Cuotas" type="number">
                  </ion-input>
                </ion-col>
              </ion-row>

              <ion-row>
                <ion-col>
                  <ion-input v-model="form_data.interest" fill="outline" label-placement="floating" label="Interes"
                    type="number" step="0.001">
                  </ion-input>
                </ion-col>
              </ion-row>

              <ion-row>
                <ion-col>
                  <ion-button expand="block" type="submit">Calcular</ion-button>
                </ion-col>
              </ion-row>
            </form>
          </ion-card-content>
        </ion-card>
      </ion-grid>

    </ion-content>
  </ion-page>
</template>

<script setup>
import {
  IonTitle,
  IonSelect,
  IonSelectOption,
  IonGrid,
  IonRow,
  IonCol,
  IonContent,
  IonHeader,
  IonPage,
  IonToolbar,
  IonCard,
  IonCardContent,
  IonMenuButton,
  IonButtons,
  IonButton,
  IonInput,
  alertController,
  IonIcon,
} from '@ionic/vue';
import {
  barcodeOutline,
  barcodeSharp,
} from 'ionicons/icons';
import { ref, computed, toRaw, } from 'vue';

const default_form = {
  loan: "",
  quotas_to_pay: "",
  interest: "",
};


const form_data = ref({ ...default_form });

const hasFormChanged = computed(() => {
  return Object.keys(form_data.value).some((field) => {
    return form_data.value[field] !== default_form[field];
  });
})

const isFormComplete = computed(() => {
  return Object.keys(form_data.value).every((field) => {
    return form_data.value[field] !== default_form[field];
  });
})

const handleSubmit = async () => {
  if (!isFormComplete.value) {
    const alert = await alertController.create({
      header: 'Error',
      message: 'Formulario incompleto',
      buttons: ['ok'],
    });
    await alert.present();
    return;
  }

  const quo = french_amortization(parseFloat(form_data.value.loan), parseInt(form_data.value.quotas_to_pay), parseFloat(form_data.value.interest))
  console.log(parseFloat(form_data.value.loan), parseInt(form_data.value.quotas_to_pay), parseFloat(form_data.value.interest));
  const amnt = parseFloat(form_data.value.loan) - quo;

  // TEMPORAL
  const alert = await alertController.create({
    header: 'SUCCESS',
    message: `Cuota: ${quo.toFixed(2)} ===> Deuda: ${amnt.toFixed(2)/100}`,
    buttons: ['ok'],
  });
  await alert.present();

  console.log(toRaw(form_data.value));
  // END_TEMPORAL
}

const french_amortization = (loan, quotas_to_pay, interest) => {
  // return loan / ( 1 - Math.pow( 1 / (1 + interest), quotas_to_pay) ) / interest;
  return (interest*Math.pow(1+interest, quotas_to_pay))*loan/((Math.pow(1+interest, quotas_to_pay))-1);
}
</script>

<style scoped>
#container {
  text-align: center;
  position: absolute;
  left: 0;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
}

#container strong {
  font-size: 20px;
  line-height: 26px;
}

#container p {
  font-size: 16px;
  line-height: 22px;
  color: #8c8c8c;
  margin: 0;
}

#container a {
  text-decoration: none;
}
</style>
