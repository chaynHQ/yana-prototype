<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
    scrollable
    transition="dialog-bottom-transition"
  >
    <v-card v-if="show">
      <v-card-title primary-title>
        <span class="headline">Why YANA?</span>
        <v-spacer></v-spacer>
        <v-btn color="primary" @click.stop="$emit('done')">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text>
        <div class="pt-3">
          TODO
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
