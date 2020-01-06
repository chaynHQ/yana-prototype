<template>
  <section id="what-happened">
    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <div v-if="intro" class="mt-3">
        <p class="body-2">
          You may have difficulty remembering what happened to you. This is
          natural. You can fill in as much or as little as you want and feel
          free to step away and come back as often as you need. You can later
          choose to email yourself these notes and show them to support workers
          or the police if you find it hard to remember.
        </p>

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

      <div v-else class="mt-3">
        <p v-if="!intro" class="body-2">
          Add information about the incident in as much detail as you’re
          comfortable with. Start with what you remember first. Enter each part
          of the incident separately. For example: I arrived at [location] and
          spoke to [x]. Click the ‘plus’ button to add what happened next. For
          example: I then spoke to [x]. Breaking down the incident in this way
          will help if you’re reporting your assault to the police and you can
          refer back to this. You can come back to this and add more details if
          other details come to you later.
        </p>

        <p class="body-2">
          We’ll use the cards to create a timeline so add approximate times if
          you remember them. You can re-arrange these later.
        </p>
      </div>
    </div>

    <incident v-if="!intro"></incident>
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
