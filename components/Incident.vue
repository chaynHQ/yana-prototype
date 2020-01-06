<template>
  <div>
    <div class="mt-10 px-3">
      <h2 class="subtitle-2 font-weight-bold">
        Time period for the whole incident
      </h2>

      <v-row>
        <v-col cols="6" class="py-0">
          <v-dialog
            ref="fromDateDialog"
            v-model="fromDateModal"
            :return-value.sync="fromDate"
            persistent
          >
            <template v-slot:activator="{ on }">
              <v-text-field
                v-model="fromDate"
                v-on="on"
                label="From"
                readonly
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
                v-model="toDate"
                v-on="on"
                label="To"
                readonly
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
    </div>

    <div class="mt-6">
      <h2 class="px-3 mb-3 subtitle-2 font-weight-bold">
        Timeline of events within the incident
      </h2>

      <p v-if="events.length == 0" class="px-3 body-2 font-italic">
        No events recorded yet.
      </p>

      <v-card
        v-for="e in events"
        :key="e.id"
        v-on:click="selectedEvent = e"
        class="mb-2"
        elevation="0"
      >
        <v-card-title class="subtitle-2 flex-nowrap">
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
                <span v-if="e.when.date">{{ e.when.date }}</span>
                <span v-if="!e.when.date" class="font-italic grey--text">
                  no date
                </span>
                <span v-if="e.when.time">
                  <span v-if="e.when.date"> – </span>
                  {{ e.when.time }}
                </span>
                <span v-if="!e.when.time" class="font-italic grey--text">
                  no time
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
          <div class="flex-nowrap">
            <p
              v-if="e.what.details"
              class="body-2 d-block text-truncate text-no-wrap"
            >
              {{ e.what.details }}
            </p>
            <p v-else class="body-2 font-italic grey--text">No details yet</p>
          </div>
          <div>
            <v-chip
              v-if="e.where.place"
              small
              color="#F2D5CB"
              text-color="primary"
            >
              {{ e.where.place }}
            </v-chip>
            <span v-else class="font-italic grey--text">
              No location specified
            </span>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-btn v-on:click.stop="deleteEvent(e.id)" text small color="warning">
            Remove
          </v-btn>
        </v-card-actions>
      </v-card>
    </div>

    <v-row class="mt-6 px-3">
      <v-col cols="8" class="py-0 d-flex">
        <p
          class="mb-0 align-self-center grey--text text--darken-2"
          style="font-size: 12px; line-height: 1.33;"
        >
          Use the plus button to add a new event to the timeline.
        </p>
      </v-col>
      <v-col cols="4" class="py-0 text-right">
        <v-btn v-on:click="newEvent()" color="primary" fab dark depressed>
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <incident-event-form
      :event="selectedEvent"
      v-on:done="selectedEvent = null"
    ></incident-event-form>
  </div>
</template>

<script>
import _ from 'lodash'
import nanoid from 'nanoid'

import IncidentEventForm from '@/components/IncidentEventForm'

export default {
  components: { IncidentEventForm },
  data() {
    return {
      fromDateModal: false,
      toDateModal: false,
      fromDate: null,
      toDate: null,
      events: [],
      selectedEvent: null
    }
  },
  methods: {
    newEvent() {
      const event = {
        id: nanoid(8),
        what: {},
        when: {},
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
    }
  }
}
</script>

<style></style>
