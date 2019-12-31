<template>
  <section id="what-happened">
    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <p class="body-2 mt-3">
        You may have difficulty remembering what happened to you. This is
        natural. You can fill in as much or as little as you want and feel free
        to step away and come back as often as you need. You can later choose to
        email yourself these notes and show them to support workers or the
        police if you find it hard to remember.
      </p>
    </div>

    <div v-if="intro" class="px-3">
      <p class="body-2">
        We will ask you questions to help you fill out as many details as you
        can.
      </p>

      <v-btn
        v-on:click="intro = false"
        class="mt-4 text-uppercase"
        color="primary"
        large
        block
      >
        Fill in details
      </v-btn>
    </div>

    <incident v-else></incident>
  </section>
</template>

<script>
import Incident from '@/components/Incident'

export default {
  components: { Incident },
  data() {
    return {
      intro: true
    }
  }
}
</script>
