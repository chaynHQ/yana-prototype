<template>
  <div>
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
      </div>
    </div>

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

import IncidentEventCard from '@/components/IncidentEventCard'
import IncidentEventForm from '@/components/IncidentEventForm'

export default {
  components: { IncidentEventCard, IncidentEventForm },
  props: {
    events: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
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
  methods: {
    formatDate(value) {
      return value ? format(parseISO(value), 'MMM do yyyy') : ''
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
    eventUpdated() {
      this.selectedEvent = null
    }
  }
}
</script>
