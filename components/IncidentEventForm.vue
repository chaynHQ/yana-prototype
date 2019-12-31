<template>
  <v-dialog
    v-model="show"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <v-card v-if="show">
      <v-card-title>
        <span class="headline">Event</span>
        <v-spacer></v-spacer>
        <v-btn v-on:click.stop="done()" color="primary">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text class="pa-0" style="height: 500px;">
        <v-form>
          <v-stepper non-linear vertical class="elevation-0">
            <v-stepper-step editable step="1">
              What happened?
            </v-stepper-step>
            <v-stepper-content step="1">
              <v-textarea
                v-model="event.what.description"
                filled
                label="Briefly describe what happened"
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="2">
              When did it happen?
            </v-stepper-step>
            <v-stepper-content step="2">
              <v-row>
                <v-col cols="6" class="py-0">
                  <v-dialog
                    ref="dateDialog"
                    v-model="dateModal"
                    :return-value.sync="event.when.date"
                    persistent
                  >
                    <template v-slot:activator="{ on }">
                      <v-text-field
                        v-model="event.when.date"
                        v-on="on"
                        label="Date"
                        readonly
                      ></v-text-field>
                    </template>
                    <v-date-picker v-model="event.when.date" scrollable>
                      <v-spacer></v-spacer>
                      <v-btn @click="dateModal = false" text color="primary"
                        >Cancel</v-btn
                      >
                      <v-btn
                        @click="$refs.dateDialog.save(event.when.date)"
                        text
                        color="primary"
                        >OK</v-btn
                      >
                    </v-date-picker>
                  </v-dialog>
                </v-col>
                <v-col cols="6" class="py-0">
                  <v-dialog
                    ref="timeDialog"
                    v-model="timeModal"
                    :return-value.sync="event.when.time"
                    persistent
                  >
                    <template v-slot:activator="{ on }">
                      <v-text-field
                        v-model="event.when.time"
                        v-on="on"
                        label="Time"
                        readonly
                      ></v-text-field>
                    </template>
                    <v-time-picker v-model="event.when.time">
                      <v-spacer></v-spacer>
                      <v-btn @click="timeModal = false" text color="primary"
                        >Cancel</v-btn
                      >
                      <v-btn
                        @click="$refs.timeDialog.save(event.when.time)"
                        text
                        color="primary"
                        >OK</v-btn
                      >
                    </v-time-picker>
                  </v-dialog>
                </v-col>
              </v-row>

              <v-checkbox
                v-model="event.when.approximate"
                label="Check this box if these times are approximate"
              ></v-checkbox>
            </v-stepper-content>

            <v-stepper-step editable step="3">
              Where did it happen?
              <small>This section is optional</small>
            </v-stepper-step>
            <v-stepper-content step="3">
              <p class="body-2">
                Can you remember the location of your assault? Was it any of the
                following? Feel free to click through and make any notes you
                think may be helpful later.
              </p>

              <v-radio-group v-model="event.where.place" :mandatory="false">
                <v-radio
                  v-for="o in whereOptions"
                  :key="o"
                  :label="o"
                  :value="o"
                ></v-radio>
              </v-radio-group>

              <v-textarea
                v-model="event.where.notes"
                filled
                label="Extra notes"
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="4">
              Who was there?
              <small>This section is optional</small>
            </v-stepper-step>
            <v-stepper-content step="4"> </v-stepper-content>

            <v-stepper-step editable step="5">
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
    event: {
      type: Object,
      required: false,
      default: null
    }
  },
  data() {
    return {
      dateModal: false,
      timeModal: false,
      whereOptions: [
        'Own home',
        "Someone's residence",
        "Abuser's residence",
        'Office',
        'Other'
      ]
    }
  },
  computed: {
    show() {
      return !!this.event
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
