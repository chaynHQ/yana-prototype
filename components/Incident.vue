<template>
  <div>
    <div class="mt-3 px-3">
      <!-- <v-alert
        v-if="onboardingCompleted"
        border="top"
        colored-border
        type="info"
        elevation="1"
        dismissible
        class="long-alert"
      >
        <p class="body-2 font-weight-bold">
          Thank you!
        </p>
        <p class="body-2 mb-0">
          You did it! These are now separate events in your timeline.
        </p>
      </v-alert> -->

      <v-snackbar v-model="onboardingCompleted" vertical multi-line top>
        <p class="body-2 font-weight-bold">
          Thank you!
        </p>
        <p class="body-2 mb-0">
          You did it! These are now separate events in your timeline.
        </p>
        <v-btn color="pink" text @click="onboardingCompleted = false">
          Close
        </v-btn>
      </v-snackbar>

      <p class="body-2">
        Click on events to enter more information like time and place. Press the
        ‘plus’ button to add new events as you remember them.
      </p>

      <p class="body-2">
        You can fill in as much or as little as you want and feel free to step
        away and come back as often as you need. Your timeline is saved
        automatically on your device and you can use it if you decide to report.

        <v-tooltip bottom content-class="app-tooltip">
          <template v-slot:activator="{ on }">
            <v-icon class="ml-1" v-on="on">mdi-help-circle</v-icon>
          </template>
          <span>
            Entering an approximate time will rearrange your timeline
            automatically.
          </span>
        </v-tooltip>
      </p>
    </div>

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

        <incident-event-card
          v-for="e in sortedEvents"
          :key="e.id"
          ref="event"
          :event="e"
          @click="selectedEvent = e"
          @delete="$emit('delete', $event)"
        ></incident-event-card>

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

        <div v-if="events.length" class="mt-8 d-flex justify-space-between">
          <v-btn color="primary" small>
            <v-icon left>mdi-pdf-box</v-icon>
            Download
          </v-btn>

          <v-btn color="warning" class="ml-3" small @click="$emit('deleteAll')">
            <v-icon left>mdi-delete</v-icon>
            Start again
          </v-btn>
        </div>
      </div>
    </div>

    <incident-timeline-onboarding
      :show="showOnboarding"
      @skip="skipOnboarding"
      @done="finishOnboarding"
    ></incident-timeline-onboarding>

    <incident-event-form
      :event="selectedEvent"
      @done="eventUpdated()"
    ></incident-event-form>
  </div>
</template>

<script>
import { nanoid } from 'nanoid'
import parseISO from 'date-fns/parseISO'
import format from 'date-fns/format'
import compareAsc from 'date-fns/compareAsc'

import IncidentTimelineOnboarding from '@/components/IncidentTimelineOnboarding'
import IncidentEventCard from '@/components/IncidentEventCard'
import IncidentEventForm from '@/components/IncidentEventForm'

export default {
  components: {
    IncidentTimelineOnboarding,
    IncidentEventCard,
    IncidentEventForm
  },
  props: {
    events: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      showOnboarding: false,
      onboardingCompleted: false,
      selectedEvent: null
    }
  },
  computed: {
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
  mounted() {
    if (this.events.length === 0) {
      setTimeout(() => (this.showOnboarding = true), 300)
    }
  },
  methods: {
    formatDate(value) {
      return value ? format(parseISO(value), 'MMM do yyyy') : ''
    },
    skipOnboarding() {
      this.showOnboarding = false
      this.onboardingCompleted = false
    },
    finishOnboarding(text) {
      text.split(/\r?\n/).forEach((t) => {
        if (t) {
          this._newEvent(t)
        }
      })
      this.persistEvents()
      this.showOnboarding = false
      this.onboardingCompleted = true
    },
    newEvent() {
      this.selectedEvent = this._newEvent()
    },
    _newEvent(whenDetails) {
      const event = {
        id: nanoid(8),
        created: new Date().toISOString(),
        when: {},
        what: {
          details: whenDetails
        },
        where: {},
        people: {},
        evidence: {}
      }
      this.events.push(event)
      return event
    },
    eventUpdated() {
      this.persistEvents()

      const id = this.selectedEvent.id
      this.selectedEvent = null
      const element = this.findElementForEvent(id)
      setTimeout(() => this.$vuetify.goTo(element), 200)
    },
    findElementForEvent(id) {
      const index = this.events.findIndex((e) => e.id === id)
      return this.$refs.event[index]
    },
    persistEvents() {
      this.$emit('save')
    }
  }
}
</script>
