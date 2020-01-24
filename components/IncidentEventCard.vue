<template>
  <v-card
    class="mb-3 event-card"
    :ripple="false"
    :class="{ invalid: !isValid(event) }"
    @click="$emit('click', $event)"
  >
    <v-card-title primary-title class="subtitle-2 flex-nowrap font-weight-bold">
      <span>
        <span v-if="event.when.dontKnow">
          Date/time not known
        </span>
        <span v-else>
          <span
            v-if="!event.when.date && !event.when.time"
            class="font-italic grey--text"
          >
            No date/time specified
          </span>
          <span v-else>
            <span v-if="event.when.date">{{
              formatDate(event.when.date)
            }}</span>
            <span v-if="event.when.time">
              {{ event.when.time }}
            </span>
            <span v-if="event.when.approximate">
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
        v-if="!isValid(event)"
        type="info"
        outlined
        dense
        class="caption pa-2"
      >
        Oh no!
        <br />
        Did you want to add something here and forgot?
      </v-alert>

      <div class="flex-nowrap">
        <vue-simple-markdown
          v-if="event.what.details"
          :source="event.what.details"
          class="body-2 mb-2"
        ></vue-simple-markdown>
        <p v-else class="body-2 mb-2 font-italic grey--text">
          No details provided on what happened
        </p>
      </div>

      <div>
        <span v-if="event.where.place">
          Location:
          <v-chip
            pill
            small
            label
            color="#F2D5CB"
            text-color="primary"
            class="px-2 ml-1"
          >
            {{ event.where.place }}
          </v-chip>
        </span>
        <span v-else class="font-italic grey--text">
          No location specified
        </span>
      </div>

      <div v-if="hasMore(event)">
        <v-btn
          small
          text
          :ripple="false"
          color="primary"
          class="caption pl-0 pb-0"
          style="display: block;"
          @click.stop="$set(event, 'expanded', !event.expanded)"
        >
          <span v-if="event.expanded">
            Hide...
          </span>
          <span v-else>
            More...
          </span>
        </v-btn>

        <v-expand-transition>
          <div v-show="event.expanded">
            <div v-if="event.where.details" class="mt-2 bordered-top">
              <p class="body-2">Where did it happen?</p>

              <vue-simple-markdown
                :source="event.where.details"
                class="body-2"
              ></vue-simple-markdown>
            </div>
            <div v-if="event.people.details" class="mt-2 bordered-top">
              <p class="body-2">Who was there?</p>

              <vue-simple-markdown
                :source="event.people.details"
                class="body-2"
              ></vue-simple-markdown>
            </div>
            <div v-if="event.evidence.details" class="mt-2 bordered-top">
              <p class="body-2">Evidence</p>

              <vue-simple-markdown
                :source="event.evidence.details"
                class="body-2"
              ></vue-simple-markdown>
            </div>
          </div>
        </v-expand-transition>
      </div>

      <div class="mt-3">
        <v-btn
          icon
          small
          color="warning"
          class="float-right"
          style="bottom: 4px;"
          @click.stop="$emit('delete', event.id)"
        >
          <v-icon>mdi-delete-circle</v-icon>
        </v-btn>

        <span class="caption">
          Created:
          {{ formatDateTime(event.created) }}
        </span>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import parseISO from 'date-fns/parseISO'
import format from 'date-fns/format'

export default {
  props: {
    event: {
      type: Object,
      required: true
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
    hasMore(entry) {
      return (
        entry &&
        (entry.where.details || entry.people.details || entry.evidence.details)
      )
    }
  }
}
</script>

<style></style>
