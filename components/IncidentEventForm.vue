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
        <p class="body-2 px-3 pt-3 ma-0">
          Use this form to log a single event that occurred as part of the
          overall incident. All sections are optional, but please provide info
          in at least one section, as much as you can remember.
        </p>

        <v-form>
          <v-stepper non-linear vertical class="elevation-0">
            <v-stepper-step editable step="1">
              When did it happen?
              <small>Optional</small>
            </v-stepper-step>
            <v-stepper-content step="1">
              <p class="body-2">
                Do you remember the date and time of this part of the incident?
                This will add to your timeline. Don’t worry if you can’t
                remember the exact date and time.
              </p>

              <v-checkbox
                v-model="event.when.dontKnow"
                label="Check this box if you don't know"
              ></v-checkbox>

              <p class="body-2 font-weight-bold">
                OR
              </p>

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
                        :value="formatDate(event.when.date)"
                        v-on="on"
                        @click:clear="event.when.date = null"
                        :disabled="event.when.dontKnow"
                        label="Date"
                        readonly
                        clearable
                      ></v-text-field>
                    </template>
                    <v-date-picker
                      ref="datePicker"
                      v-model="event.when.date"
                      :max="new Date().toISOString().substr(0, 10)"
                    >
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
                        :disabled="event.when.dontKnow"
                        label="Time"
                        readonly
                        clearable
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
                :disabled="event.when.dontKnow"
                label="Check this box if these times are approximate"
              ></v-checkbox>
            </v-stepper-content>

            <v-stepper-step editable step="2">
              What happened?
              <small>Optional</small>
            </v-stepper-step>
            <v-stepper-content step="2">
              <p class="body-2">
                Write in as much detail as you wish to describe what happened.
                Any details you can think of may be useful, but don’t be
                disheartened if you can’t remember much.
              </p>

              <v-textarea
                v-model="event.what.details"
                filled
                solo
                dense
                hide-details
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="3">
              Where did it happen?
              <small>Optional</small>
            </v-stepper-step>
            <v-stepper-content step="3">
              <p class="body-2">
                Can you remember the location of your assault? Select any option
                and make notes that may be helpful later such as what your
                surroundings were like and any memorable items.
              </p>

              <v-radio-group v-model="event.where.place" :mandatory="false">
                <v-radio
                  v-for="o in whereOptions"
                  :key="o"
                  :label="o"
                  :value="o"
                  :ripple="false"
                ></v-radio>
              </v-radio-group>

              <v-textarea
                v-model="event.where.details"
                filled
                solo
                dense
                hide-details
                label="Extra notes"
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="4">
              Who was there?
              <small>Optional</small>
            </v-stepper-step>
            <v-stepper-content step="4">
              <p class="body-2">
                Add details about who you remember being there or was involved
                in this part of the incident. This information may help find
                suspects or witnesses during an investigation.
              </p>

              <v-textarea
                v-model="event.people.details"
                filled
                solo
                dense
                hide-details
              ></v-textarea>
            </v-stepper-content>

            <v-stepper-step editable step="5">
              Evidence
              <small>Optional</small>
            </v-stepper-step>
            <v-stepper-content step="5">
              <p class="body-2">
                Use this space to add details of anything that may be used as
                evidence for this part of the incident. E.g screenshots of call
                logs, messages, social media files, taxi receipts.
              </p>

              <v-textarea
                v-model="event.evidence.details"
                filled
                solo
                dense
                hide-details
              ></v-textarea>
            </v-stepper-content>
          </v-stepper>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import parseISO from 'date-fns/parseISO'
import format from 'date-fns/format'

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
        'Home',
        'Perpetrator’s residence',
        'Office',
        'Hotel',
        'University campus',
        'Public place (train station, etc.)',
        'Other',
        "Don't know"
      ]
    }
  },
  computed: {
    show() {
      return !!this.event
    },
    whenDontKnow() {
      return this.show && this.event.when.dontKnow
    }
  },
  watch: {
    whenDontKnow(value) {
      if (this.show && value === true) {
        this.event.when.date = undefined
        this.event.when.time = undefined
        this.event.when.approximate = undefined
      }
    },
    dateModal(value) {
      value &&
        !this.event.when.date &&
        setTimeout(() => (this.$refs.datePicker.activePicker = 'YEAR'))
    }
  },
  methods: {
    formatDate(value) {
      return value ? format(parseISO(value), 'MMM do yyyy') : ''
    },
    done() {
      this.$emit('done')
    }
  }
}
</script>

<style></style>
