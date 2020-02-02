<template>
  <v-footer app height="65" dark padless class="px-3">
    <div
      class="d-flex flex-row justify-space-between align-center"
      style="width: 100%;"
    >
      <div class="light-text caption font-weight-bold">
        &copy; 2020 Chayn
      </div>
      <div class="footer-buttons">
        <v-btn icon color="#FFF5F0" :ripple="false" @click="showBreak = true">
          <v-icon>mdi-heart</v-icon>
          <span>breathe</span>
        </v-btn>
        <v-btn
          icon
          color="#FFF5F0"
          :ripple="false"
          class="ml-4"
          @click="showInfo = true"
        >
          <v-icon>mdi-information</v-icon>
          <span>purpose</span>
        </v-btn>
        <v-btn
          icon
          color="#FFF5F0"
          :ripple="false"
          class="ml-4"
          @click="exit()"
        >
          <v-icon>mdi-exit-to-app</v-icon>
          <span>exit</span>
        </v-btn>
      </div>
    </div>

    <app-break :show="showBreak" @done="showBreak = false"></app-break>

    <app-info :show="showInfo" @done="showInfo = false"></app-info>
  </v-footer>
</template>

<script>
import AppBreak from '@/components/AppBreak'
import AppInfo from '@/components/AppInfo'

export default {
  components: { AppBreak, AppInfo },
  data() {
    return {
      showBreak: false,
      showInfo: false
    }
  },
  methods: {
    exit() {
      window.open('http://www.wikipedia.org/', '_newtab', 'noopener,noreferrer')

      window.location.replace(
        'https://www.google.com/search?tbm=isch&q=cute+baby+animal+memes'
      )
    }
  }
}
</script>

<style lang="scss">
.theme--dark.v-footer {
  background-color: #1d2445 !important;
}

.footer-buttons {
  .v-btn--icon.v-size--default {
    width: 50px;
  }

  button {
    .v-btn__content {
      flex-direction: column;

      > span {
        font-size: 0.8em;
        text-transform: none;
        font-weight: bold;
      }
    }
  }
}
</style>
