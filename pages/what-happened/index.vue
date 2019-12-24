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

    <div v-else>
      <div class="mt-10 px-3">
        <h2 class="subtitle-2 font-weight-bold">
          Time period
        </h2>
        <v-row>
          <v-col cols="6" class="py-0">
            <v-dialog
              ref="fromDateDialog"
              v-model="fromDateModal"
              :return-value.sync="fromDate"
              persistent
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  v-model="fromDate"
                  v-on="on"
                  label="From"
                  readonly
                ></v-text-field>
              </template>
              <v-date-picker v-model="fromDate" scrollable>
                <v-spacer></v-spacer>
                <v-btn @click="fromDateModal = false" text color="primary"
                  >Cancel</v-btn
                >
                <v-btn
                  @click="$refs.fromDateDialog.save(fromDate)"
                  text
                  color="primary"
                  >OK</v-btn
                >
              </v-date-picker>
            </v-dialog>
          </v-col>
          <v-col cols="6" class="py-0">
            <v-dialog
              ref="toDateDialog"
              v-model="toDateModal"
              :return-value.sync="toDate"
              persistent
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  v-model="toDate"
                  v-on="on"
                  label="To"
                  readonly
                ></v-text-field>
              </template>
              <v-date-picker v-model="toDate" :min="fromDate" scrollable>
                <v-spacer></v-spacer>
                <v-btn @click="toDateModal = false" text color="primary"
                  >Cancel</v-btn
                >
                <v-btn
                  @click="$refs.toDateDialog.save(toDate)"
                  text
                  color="primary"
                  >OK</v-btn
                >
              </v-date-picker>
            </v-dialog>
          </v-col>
        </v-row>
      </div>

      <div class="mt-6">
        <h2 class="px-3 mb-3 subtitle-2 font-weight-bold">
          Details
        </h2>

        <v-card v-for="e in entries" :key="e.id" class="mb-2">
          <v-card-title>
            <span>Entry</span>
            <v-spacer></v-spacer>
            <v-icon>
              mdi-chevron-right
            </v-icon>
          </v-card-title>
        </v-card>
      </div>

      <v-row class="mt-6 px-3">
        <v-col cols="8" class="py-0 d-flex">
          <p
            class="mb-0 align-self-center grey--text text--darken-2"
            style="font-size: 12px; line-height: 1.33;"
          >
            Use the plus button to add further entries.
          </p>
        </v-col>
        <v-col cols="4" class="py-0 text-right">
          <v-btn color="primary" fab dark depressed>
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      intro: true,
      fromDateModal: false,
      toDateModal: false,
      fromDate: null,
      toDate: null,
      entries: [{ id: '1' }, { id: '2' }]
    }
  }
}
</script>
