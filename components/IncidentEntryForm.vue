<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <v-card v-if="show">
      <v-card-title>
        <span class="headline">Entry</span>
        <v-spacer></v-spacer>
        <v-btn v-on:click.stop="done()" color="primary">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text class="pa-0" style="height: 500px;">
        <v-form>
          <v-stepper non-linear vertical class="elevation-0">
            <v-stepper-step editable step="1" class="pa-4">
              What happened?
              <small>Lorem ipsum dolor sit amet</small>
            </v-stepper-step>
            <v-stepper-content step="1">
              <v-textarea
                v-model="entry.description"
                filled
                label="Briefly describe what happened"
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="2" class="pa-4">
              When did it happen?
              <small>Lorem ipsum dolor sit amet</small>
            </v-stepper-step>
            <v-stepper-content step="2"> </v-stepper-content>

            <v-stepper-step editable step="3" class="pa-4">
              Where did it happen?
              <small>This section is optional</small>
            </v-stepper-step>
            <v-stepper-content step="3"> </v-stepper-content>

            <v-stepper-step editable step="4" class="pa-4">
              Who was there?
              <small>This section is optional</small>
            </v-stepper-step>
            <v-stepper-content step="4"> </v-stepper-content>

            <v-stepper-step editable step="5" class="pa-4">
              Evidence
              <small>This section is optional</small>
            </v-stepper-step>
            <v-stepper-content step="5"> </v-stepper-content>
          </v-stepper>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    entry: {
      type: Object,
      required: false,
      default: null
    }
  },
  data() {
    return {
      stepper: 0
    }
  },
  computed: {
    show() {
      return !!this.entry
    }
  },
  methods: {
    done() {
      this.$emit('done')
    }
  }
}
</script>

<style lang="scss" scoped></style>
