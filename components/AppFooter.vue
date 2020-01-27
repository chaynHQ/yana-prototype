<template>
  <v-footer app>
    <div class="d-flex flex-row justify-space-between" style="width: 100%;">
      <div>
        &copy; 2019 Chayn
      </div>
      <div class="">
        <v-btn icon small color="primary" @click="showBreak = true">
          <v-icon>mdi-heart</v-icon>
        </v-btn>
        <v-btn icon small color="primary" class="ml-3" @click="showInfo = true">
          <v-icon>mdi-information</v-icon>
        </v-btn>
        <v-btn text small color="primary" class="ml-5">
          Leave
          <v-icon right>mdi-exit-to-app</v-icon>
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
  }
}
</script>

<style></style>
