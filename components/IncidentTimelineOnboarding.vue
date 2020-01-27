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
      <v-divider></v-divider>
      <v-card-text style="height: 500px;">
        <div class="pt-3">
          <p class="body-2">
            Take a minute and write down anything you remember about what
            happened. We’ll call this an incident. Different parts of the
            incident will be called 'events'. This will create your own record,
            regardless of whether you report or not.
          </p>

          <p class="body-2 font-weight-bold">
            Add each event in a new paragraph. We'll convert this into a
            timeline for you.
          </p>

          <p class="body-2">
            Don’t worry about adding too much detail just yet. You can do that
            later.
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
              I met the perpetrator at a bar recently in downtown Soho. They
              were very friendly initially but seemed to get really angry all of
              a sudden, for no reason.
            </p>
            <p>
              After a couple of drinks, we went to a restaurant to get some
              food.
            </p>
            <p>
              Then we met up with some friends...
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
