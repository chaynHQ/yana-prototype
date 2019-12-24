<template>
  <section id="what-happened">
    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <p class="body-2 mt-3">
        You may have difficulty remembering what happened to you. This is
        natural. You can fill as much or as little as you want. You can email
        this information to yourself and show it any support worker or law
        enforcement if you find it hard to remember.
      </p>
    </div>

    <div v-if="intro" class="px-3">
      <p class="body-2">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna wirl aliqua. Ut enim ad
        minim ikad veniam, quis nostrud exercitatn ullamco laboris aliquip.
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
