<template>
  <div>
    <!-- <div class="mt-10 px-1">
      <h2 class="subtitle-2 font-weight-bold">
        Time period for the whole incident
      </h2>

      <v-row class="mt-3 px-3">
        <v-col cols="6" class="py-0">
          <v-dialog
            ref="fromDateDialog"
            v-model="fromDateModal"
            :return-value.sync="fromDate"
            persistent
          >
            <template v-slot:activator="{ on }">
              <v-text-field
                :value="formattedFromDate"
                v-on="on"
                @click:clear="fromDate = null"
                label="From"
                readonly
                clearable
              ></v-text-field>
            </template>
            <v-date-picker v-model="fromDate" scrollable>
              <v-spacer></v-spacer>
              <v-btn @click="fromDateModal = false" text color="primary"
                >Cancel</v-btn
              >
              <v-btn
                @click="$refs.fromDateDialog.save(fromDate)"
                text
                color="primary"
                >OK</v-btn
              >
            </v-date-picker>
          </v-dialog>
        </v-col>
        <v-col cols="6" class="py-0">
          <v-dialog
            ref="toDateDialog"
            v-model="toDateModal"
            :return-value.sync="toDate"
            persistent
          >
            <template v-slot:activator="{ on }">
              <v-text-field
                :value="formattedToDate"
                v-on="on"
                @click:clear="toDate = null"
                label="To"
                readonly
                clearable
              ></v-text-field>
            </template>
            <v-date-picker v-model="toDate" :min="fromDate" scrollable>
              <v-spacer></v-spacer>
              <v-btn @click="toDateModal = false" text color="primary"
                >Cancel</v-btn
              >
              <v-btn
                @click="$refs.toDateDialog.save(toDate)"
                text
                color="primary"
                >OK</v-btn
              >
            </v-date-picker>
          </v-dialog>
        </v-col>
      </v-row>

      <p class="px-3 body-2">
        Leave either blank if you're not sure
      </p>
    </div> -->

    <div class="mt-6 px-3">
      <h2 class="mb-1 subtitle-2 font-weight-bold">
        Timeline of events within the incident
      </h2>

      <div class="timeline pt-3 pl-3">
        <p v-if="events.length != 0" class="inferred-dates body-2">
          <span>
            <strong>From:</strong>
            <span v-if="inferredTimeline.from">
              {{ formatDate(inferredTimeline.from) }}
            </span>
            <span v-else class="none-text">
              unknown
            </span>
          </span>

          <span class="ml-3">
            <strong>To:</strong>
            <span v-if="inferredTimeline.to">
              {{ formatDate(inferredTimeline.to) }}
            </span>
            <span v-else class="none-text">
              unknown
            </span>
          </span>
        </p>

        <div v-if="events.length == 0" class="px-2">
          <p class="body-2 font-italic">
            No events recorded yet.
          </p>
          <p class="body-2">
            Add <strong>separate</strong> events using the '+' button below. For
            example: one event can be "I arrived at [location] and spoke to
            [x]", then the next event can be "I then spoke to [y]".
          </p>
        </div>

        <v-card
          v-for="e in sortedEvents"
          :key="e.id"
          class="mb-3 event-card"
          :class="{ invalid: !isValid(e) }"
          @click="selectedEvent = e"
        >
          <v-card-title class="subtitle-2 flex-nowrap font-weight-bold">
            <span>
              <span v-if="e.when.dontKnow">
                Date/time not known
              </span>
              <span v-else>
                <span
                  v-if="!e.when.date && !e.when.time"
                  class="font-italic grey--text"
                >
                  No date/time specified
                </span>
                <span v-else>
                  <span v-if="e.when.date">{{ formatDate(e.when.date) }}</span>
                  <span v-if="e.when.time">
                    {{ e.when.time }}
                  </span>
                  <span v-if="e.when.approximate">
                    (approx)
                  </span>
                </span>
              </span>
            </span>
            <v-spacer></v-spacer>
            <v-icon>
              mdi-chevron-right
            </v-icon>
          </v-card-title>
          <v-card-text>
            <v-alert
              v-if="!isValid(e)"
              type="error"
              dense
              outlined
              class="caption pa-2"
            >
              Missing info
              <br />
              Fill in at least one section
            </v-alert>

            <div class="flex-nowrap">
              <p
                v-if="e.what.details"
                class="body-2 mb-2 d-block text-truncate text-no-wrap"
              >
                {{ e.what.details }}
              </p>
              <p v-else class="body-2 mb-2 font-italic grey--text">
                No details provided on what happened
              </p>
            </div>
            <div>
              <span v-if="e.where.place">
                Location:
                <v-chip
                  pill
                  small
                  label
                  color="#F2D5CB"
                  text-color="primary"
                  class="px-2 ml-1"
                >
                  {{ e.where.place }}
                </v-chip>
              </span>
              <span v-else class="font-italic grey--text">
                No location specified
              </span>
            </div>
            <div class="mt-3">
              <v-btn
                icon
                small
                color="warning"
                class="float-right"
                style="bottom: 4px;"
                @click.stop="deleteEvent(e.id)"
              >
                <v-icon>mdi-delete-circle</v-icon>
              </v-btn>

              <span class="caption">
                Created:
                {{ formatDateTime(e.created) }}
              </span>
            </div>
          </v-card-text>
        </v-card>

        <v-row class="mt-4 px-2">
          <v-col cols="8" class="py-0 d-flex">
            <p
              class="mb-0 align-self-center grey--text text--darken-2"
              style="font-size: 12px; line-height: 1.33;"
            >
              Use the plus button to add a new event to the timeline.
            </p>
          </v-col>
          <v-col cols="4" class="py-0 text-right">
            <v-btn color="primary" fab dark depressed @click="newEvent()">
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </v-col>
        </v-row>
      </div>
    </div>

    <incident-event-form
      :event="selectedEvent"
      @done="eventUpdated()"
    ></incident-event-form>
  </div>
</template>

<script>
import _ from 'lodash'
import nanoid from 'nanoid'
import parseISO from 'date-fns/parseISO'
import format from 'date-fns/format'
import compareAsc from 'date-fns/compareAsc'

import IncidentEventForm from '@/components/IncidentEventForm'

export default {
  components: { IncidentEventForm },
  props: {
    events: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      // fromDateModal: false,
      // toDateModal: false,
      // fromDate: null,
      // toDate: null,
      selectedEvent: null
    }
  },
  computed: {
    // formattedFromDate() {
    //   return this.formatDate(this.fromDate)
    // },
    // formattedToDate() {
    //   return this.formatDate(this.toDate)
    // },
    sortedEvents() {
      // Make sure not to mutate the underlying list
      return [...this.events].sort((a, b) => {
        if (a.when.dontKnow) {
          if (b.when.dontKnow) {
            return 0
          } else if (b.when.date) {
            return -1
          } else {
            return 1
          }
        } else if (a.when.date) {
          if (b.when.dontKnow) {
            return 1
          } else if (b.when.date) {
            if (a.when.date === b.when.date) {
              if (!a.when.time || !b.when.time) {
                if (!a.when.time && !b.when.time) {
                  return 0
                } else if (!a.when.time) {
                  return -1
                } else {
                  return 1
                }
              }

              return a.when.time.localeCompare(b.when.time)
            } else {
              return compareAsc(parseISO(a.when.date), parseISO(b.when.date))
            }
          } else {
            return 1
          }
        } else if (b.when.dontKnow) {
          return -1
        } else if (b.when.date) {
          return -1
        } else {
          return 0
        }
      })
    },
    inferredTimeline() {
      if (this.sortedEvents.length) {
        const firstEventWithDate = this.sortedEvents.find((e) => e.when.date)
        let from = null
        if (firstEventWithDate) {
          from = firstEventWithDate.when.date
        }

        // Based on the sorting, we can assume that the last item is the chronologically last one (assuming it has a date set)
        const to = this.sortedEvents[this.sortedEvents.length - 1].when.date

        return { from, to }
      } else {
        return {}
      }
    }
  },
  methods: {
    formatDate(value) {
      return value ? format(parseISO(value), 'MMM do yyyy') : ''
    },
    formatDateTime(value) {
      return value ? format(parseISO(value), 'MMM do yyyy p') : ''
    },
    isValid(entry) {
      return (
        entry &&
        (entry.when.dontKnow ||
          entry.when.date ||
          entry.what.details ||
          entry.where.place ||
          entry.people.details ||
          entry.evidence.details)
      )
    },
    newEvent() {
      const event = {
        id: nanoid(8),
        created: new Date().toISOString(),
        when: {},
        what: {},
        where: {},
        people: {},
        evidence: {}
      }
      this.events.push(event)
      this.selectedEvent = event
    },
    deleteEvent(id) {
      this.$dialog
        .warning({
          text: 'Are you sure you want remove this event?',
          title: 'Confirm',
          persistent: true
        })
        .then((result) => {
          if (result) {
            this.events = _.filter(this.events, (e) => e.id !== id)
          }
        })
    },
    eventUpdated() {
      this.selectedEvent = null
    }
  }
}
</script>
