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
          remember, which you can later choose to email yourself and show them
          to support workers or the police if you find it hard to remember or
          repeatedly recall.
        </p>

        <p class="body-2">
          You can fill in as much or as little as you want and feel free to step
          away and come back as often as you need.
        </p>

        <p class="body-2">
          We will ask you questions to help you fill out as many details as you
          can.
        </p>

        <v-btn
          class="mt-4 text-uppercase"
          color="primary"
          large
          block
          @click="intro = false"
        >
          Start Building Your Timeline
        </v-btn>
      </div>
    </div>

    <incident
      v-if="!intro"
      :events="events"
      @delete="deleteEvent($event)"
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
    }
  },
  methods: {
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
