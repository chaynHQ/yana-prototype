<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
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
        <div class="pt-3">
          <p class="body-2">
            Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Voluptatibus quam quaerat distinctio qui earum iusto quos modi!
            Nobis, natus quo. Porro nesciunt, ducimus distinctio maiores
            laudantium ab voluptate iure pariatur.
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
