<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-menu-button color="primary"></ion-menu-button>
        </ion-buttons>
        <ion-title>Atencion</ion-title>
      </ion-toolbar>
      <ion-toolbar>
        <ion-searchbar />
          <ion-buttons slot="end">
            <ion-button> <!-- @click="" -->
              <ion-icon aria-hidden="true" slot="icon-only" :ios="barcodeOutline" :md="barcodeSharp" />
            </ion-button>
          </ion-buttons>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Atencion</ion-title>
        </ion-toolbar>
      </ion-header>

      <ion-fab vertical="bottom" horizontal="end" slot="fixed">
        <ion-fab-button router-direction="forward" router-link="/atencion/fab">
          <ion-icon :ios="addOutline" :md="addSharp" />
          <!-- <ion-icon :icon="add"></ion-icon> -->
        </ion-fab-button>
      </ion-fab>


      <ion-grid class="ion-justify-content-center">
        <ion-card>
          <ion-card-content>
            <h2>test</h2>
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
  IonIcon,
  IonFab,
  IonFabButton,

} from '@ionic/vue';
import {
  barcodeOutline,
  barcodeSharp,
  addOutline,
  addSharp,
} from 'ionicons/icons';
import { ref, computed, toRaw, capitalize, } from 'vue';

const PERIOD_TYPE_CONSTS = [
  { value: "years", label: "años" },
  { value: "months", label: "meses" },
  { value: "days", label: "dias" },
]
const default_form = {
  capital: "",
  interest_rate: "",
  period: "",
  period_type: PERIOD_TYPE_CONSTS[0].value,
};


const form_data = ref({ ...default_form });

const hasFormChanged = computed(() => {
  return Object.keys(form_data.value).some((field) => {
    return form_data.value[field] !== default_form[field];
  });
})

const isFormComplete = computed(() => {
  return Object.keys(form_data.value).every((field) => {
    if ( field === "period_type" )
      return true;
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

  const inte = simple_interest(parseFloat(form_data.value.capital), parseFloat(form_data.value.interest_rate), parseInt(form_data.value.period), form_data.value.period_type)
  console.log(parseFloat(form_data.value.capital), parseFloat(form_data.value.interest_rate), parseInt(form_data.value.period), form_data.value.period_type)
  // const inte = compound_interest(parseInt(form_data.value.capital), parseFloat(form_data.value.interest_rate), parseInt(form_data.value.period), form_data.value.period_type)
  const amnt = parseFloat(form_data.value.capital) + inte;
  // TEMPORAL
    const alert = await alertController.create({
      header: 'SUCCESS',
      message: `Interes: ${inte.toFixed(2)} ===> Monto: ${amnt.toFixed(2)}`,
      buttons: ['ok'],
    });
    await alert.present();

    console.log(toRaw(form_data.value));
  // END_TEMPORAL
}

const simple_interest = ( capital, interest, period, period_type = "years") => {
  let period_type_number;
  console.log(capital, interest, period, period_type)

  if ( period_type === "days" ) {
    period_type_number = 1/360;
  } else if ( period_type === "months" ) {
    period_type_number = 1/12;
  } else if ( period_type === "years" ) {
    period_type_number = 1;
  } else {
    console.log("Error: period_type invalid");
    return;
  }

  return capital * interest * period * period_type_number;
}

const compound_interest = ( capital, interest, period, period_type = "years") => {
  let period_type_number;

  if ( period_type === "days" ) {
    period_type_number = 360;
  } else if ( period_type === "months" ) {
    period_type_number = 12;
  } else if ( period_type === "years" ) {
    period_type_number = 1;
  } else {
    console.log("Error: period_type invalid");
    return;
  }

  return capital * Math.pow(1 + interest/period_type_number, period * period_type_number) - 1;
}


const handlePeriodTypeChange = (ev) => {
  form_data.value.period_type = ev.detail.value;
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
