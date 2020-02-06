<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
    scrollable
    transition="dialog-bottom-transition"
  >
    <v-card v-if="show" class="app-info-dialog">
      <v-card-title primary-title>
        <span class="headline">WHY yana?</span>
        <v-spacer></v-spacer>
        <v-btn color="primary" @click.stop="$emit('done')">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text>
        <div class="pt-4">
          <p class="body-1">
            We know how isolating it can feel after abuse. It can be hard to
            piece together what happened, open up and get help.
          </p>

          <p class="body-1">
            You Are Not Alone was created by a team of survivors and people who
            want to help you through this time.
          </p>

          <p class="body-1">
            Statistics on conviction rates and the process of reporting can seem
            bleak and make you feel even more alone.
          </p>

          <p class="body-1">
            Our hope is that through the use of this tool you can keep a safe
            record of what’s happened to you. So you can refer back to it if you
            need to recount the events to anyone else, and to help you build
            your case if you do decide to take any legal action.
          </p>

          <p class="body-1">
            We’ve also gathered all the information you might need to help you
            feel more in control of what is happening, and access the support
            you need.
          </p>

          <p class="body-1">
            Whatever happens, we’re here for you. You are not alone.
          </p>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    show: {
      type: Boolean,
      required: true
    }
  }
}
</script>

<style></style>
