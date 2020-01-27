<template>
  <v-dialog
    v-model="show"
    transition="slide-x-transition"
    scrollable
    persistent
  >
    <v-card>
      <v-card-title primary-title>
        <span class="headline">Start your timeline</span>
      </v-card-title>
      <v-card-text style="height: 500px;">
        <div>
          <p class="body-2">
            Take a minute and try and write down anything you remember about
            what happened. Try to put each part of the incident into a new
            paragraph, and we'll convert this into an initial timeline for you
            to then build on.
          </p>

          <p class="body-2">
            Don’t worry about adding too much detail just yet, as you’ll be able
            to add more steps and edit events to add the timing etc. later.
          </p>

          <v-textarea
            v-model="text"
            filled
            dense
            auto-grow
            hide-details
            autofocus
          ></v-textarea>
          <div class="mt-3 d-flex justify-space-between">
            <v-btn text @click.stop="skip">Skip</v-btn>
            <v-btn color="primary" :disabled="!text" @click.stop="done">
              Done
            </v-btn>
          </div>

          <div class="mt-5 body-2 font-italic">
            <p>Example:</p>
            <p>
              I met the perpetrator at a bar recently in downtown Soho. He was
              very friendly initially, but seemed to get really angry all of a
              sudden, for no reason.
            </p>
            <p>
              After a couple of drinks, we went to a restaurant to get some
              food.
            </p>
            <p>
              Then we met up with some friends…
            </p>
          </div>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    show: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      text: null
    }
  },
  methods: {
    skip() {
      this.$emit('skip')
    },
    done() {
      const text = this.text
      this.text = null
      this.$emit('done', text)
    }
  }
}
</script>

<style></style>
