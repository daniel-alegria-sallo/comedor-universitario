<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button :text="getBackButtonText()" default-href="/atencion"></ion-back-button>
        </ion-buttons>
      </ion-toolbar>
    </ion-header>

    <ion-content scroll-y="false" :fullscreen="true">
      <ion-grid class="ion-justify-content-center">
        <ion-card>
          <ion-card-content>
            <ion-row>
              <ion-col>
                <div>
                  <strong class="capitalize">Fab</strong>
                  <p> Explore
                  <a target="_blank"
                    rel="noopener noreferrer"
                    href="https://ionicframework.com/docs/components"
                    >UI Components</a>
                  </p>
                </div>
              </ion-col>
            </ion-row>
          </ion-card-content>
        </ion-card>
      </ion-grid>

    </ion-content>
  </ion-page>
</template>

<script setup>
import {
  IonButtons,
  IonButton,
  IonContent,
  IonHeader,
  IonMenuButton,
  IonPage,
  IonTitle,
  IonToolbar,
  IonCard,
  IonCardContent,
  IonGrid,
  IonRow,
  IonCol,
  IonBackButton,
  IonSearchbar,
} from '@ionic/vue'

const getBackButtonText = () => {
  const mode = window && window.Ionic && window.Ionic.mode;
  return mode === 'ios' ? 'Fab' : '';
};
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

