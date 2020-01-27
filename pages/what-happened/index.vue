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
          We’ve created a space for you to log as much information as you can
          remember, which you can later email yourself and show to support
          workers or the police if you find it hard to repeatedly recall.
        </p>

        <p class="body-2">
          Fill in as much or as little as you want and feel free to step away
          and come back as often as you need.
        </p>

        <p class="body-2">
          All data you enter will only be stored on your device. You will be
          able to delete this data when you want.
        </p>

        <v-btn class="mt-4" color="primary" large block @click="intro = false">
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
          text: 'Are you sure you want delete all your timeline data?',
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
