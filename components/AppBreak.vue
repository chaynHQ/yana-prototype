<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
    scrollable
    transition="dialog-bottom-transition"
  >
    <v-card v-if="show" class="app-break-card">
      <v-card-title primary-title>
        <span class="headline">Take a break</span>
        <v-spacer></v-spacer>
        <v-btn color="primary" @click.stop="$emit('done')">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text>
        <div class="pt-4">
          <p class="body-2">
            Feeling overwhelmed? That’s completely understandable.
            <br />
            Take a break and try to clear your mind by focusing on your
            breathing.
          </p>

          <p class="body-2">
            Get comfortable and press start when you’re ready.
          </p>

          <breathing-exercise class="mt-6"></breathing-exercise>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import BreathingExercise from '@/components/BreathingExercise'

export default {
  components: { BreathingExercise },
  props: {
    show: {
      type: Boolean,
      required: true
    }
  }
}
</script>

<style></style>
