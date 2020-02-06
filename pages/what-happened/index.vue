<template>
  <section id="what-happened">
    <back-button :to="'/begin'" :text="'Your case'"></back-button>

    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <div v-if="intro" class="mt-3">
        <p class="body-2">
          You may have difficulty remembering what happened. This is natural.
        </p>

        <p class="body-2">
          Use this space to write as much information as you can remember, which
          you can later email yourself and show to people who can help if you
          find it hard to recall what happened.
        </p>

        <p class="body-2">
          Feel free to step away and come back later. Use the breathe icon below
          if you need to take a break.
        </p>

        <p class="body-2">
          Data will be stored on your device. Delete this whenever.
        </p>

        <v-btn class="mt-6" color="primary" large block @click="intro = false">
          Build the timeline
        </v-btn>
      </div>
    </div>

    <incident
      v-if="!intro"
      :events="events"
      @save="save"
      @delete="deleteEvent"
      @deleteAll="deleteAll"
    ></incident>
  </section>
</template>

<script>
import _ from 'lodash'

import testData from '@/data/test-data'

import BackButton from '@/components/BackButton'
import Incident from '@/components/Incident'

export default {
  components: { BackButton, Incident },
  asyncData({ query }) {
    return Promise.resolve({
      test: query.test
    })
  },
  watchQuery: ['test'],
  data() {
    return {
      intro: true,
      events: []
    }
  },
  mounted() {
    if (this.test) {
      this.events = testData.events
      this.intro = false
    } else {
      const data = localStorage.getItem('events')
      if (data) {
        try {
          this.events = JSON.parse(data)
          this.intro = false
        } catch (e) {
          console.error('Failed to parse events data from localStorage', e) // eslint-disable-line
          this.clear()
        }
      }
    }
  },
  methods: {
    save() {
      const serialised = JSON.stringify(this.events)
      localStorage.setItem('events', serialised)
    },
    clear() {
      this.events = []
      localStorage.removeItem('events')
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
            this.save()
          }
        })
    },
    deleteAll() {
      this.$dialog
        .warning({
          text:
            'Are you sure you want delete ALL your timeline data and start again?',
          title: 'Confirm',
          persistent: true
        })
        .then((result) => {
          if (result) {
            this.clear()
            this.intro = true
          }
        })
    }
  }
}
</script>
