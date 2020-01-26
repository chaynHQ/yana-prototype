<template>
  <div>
    <div class="mt-3 px-3">
      <v-alert
        v-if="onboardingFinished"
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
          These are now separate steps in your timeline. You can now click on
          these to enter more information such as the time or information on who
          was there. Press the ‘plus’ button to add a new step you remember.
          Entering an approximate time if you can will rearrange your timeline
          automatically.
        </p>
      </v-alert>

      <p class="body-2">
        Add information about the incident in as much detail as you’re
        comfortable with. Start with what you remember first. Enter each part of
        the incident separately.
      </p>

      <p class="body-2">
        Click the ‘plus’ button to add what happened next. Breaking down the
        incident in this way will help if you’re reporting your assault to the
        police and you can refer back to this. You can come back to this and add
        more details if other details come to you later.
      </p>

      <p class="body-2">
        You can add as many events as you want.
        <v-tooltip
          bottom
          color="white grey--text text--darken-2"
          content-class="app-tooltip"
        >
          <template v-slot:activator="{ on }">
            <v-icon class="ml-1" v-on="on">mdi-help-circle</v-icon>
          </template>
          <span>
            For example: Event 1: I arrived at Stockport station and spoke to my
            friend, Rohan; Event 2: I arrived at Amsterdam, NL and went to a bar
            with Rohan's friend Jack
          </span>
        </v-tooltip>
      </p>

      <p class="body-2">
        We’ll use the cards to create a timeline so add approximate times if you
        remember them. You can re-arrange these later.
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

        <div v-if="events.length" class="mt-8">
          <v-btn color="warning" block @click="$emit('deleteAll')">
            Delete all your data
          </v-btn>
        </div>
      </div>
    </div>

    <incident-timeline-onboarding
      :show="showOnboarding"
      @done="finishOnboarding($event)"
    ></incident-timeline-onboarding>

    <incident-event-form
      :event="selectedEvent"
      @done="eventUpdated()"
    ></incident-event-form>
  </div>
</template>

<script>
import nanoid from 'nanoid'
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
      onboardingFinished: false,
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
    finishOnboarding(text) {
      text.split(/\r?\n/).forEach((t) => {
        if (t) {
          this._newEvent(t)
        }
      })
      this.persistEvents()
      this.showOnboarding = false
      this.onboardingFinished = true
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
      const serialised = JSON.stringify(this.events)
      localStorage.setItem('events', serialised)
    }
  }
}
</script>
