<template>
  <section id="what-happened">
    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <div v-if="intro" class="mt-3">
        <p class="body-2">
          You may have difficulty remembering what happened to you. This is
          natural.
        </p>

        <p class="body-2">
          We’ve created a space for you to log as much information as you
          remember which you can email yourself and show to authorities so you
          don’t have to recall it repeatedly.
        </p>

        <p class="body-2">
          Fill in as much as you want. Feel free to step away and come back
          whenever you wish.
        </p>

        <p class="body-2">
          Data will be stored on your device only. Delete this whenever you
          want.
        </p>

        <v-btn class="mt-6" color="primary" large block @click="intro = false">
          Start Building Your Timeline
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

import Incident from '@/components/Incident'

export default {
  components: { Incident },
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
