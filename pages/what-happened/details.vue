<template>
  <section id="what-happened-details">
    <div class="px-3">
      <h1 class="headline">What happened?</h1>

      <p class="body-2 mt-3">
        Fill in the form below in as much detail as you want. Start by entering
        a time period for the incident. Use the plus icon to add different parts
        of the same incident. This will help us create a timeline for you.
      </p>
    </div>

    <div class="mt-10 px-3">
      <h2 class="subtitle-2 font-weight-bold">
        Time period
      </h2>
      <v-row>
        <v-col md="6">
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
        <v-col md="6">
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
  </section>
</template>

<script>
export default {
  data() {
    return {
      fromDateModal: false,
      toDateModal: false,
      fromDate: null,
      toDate: null
    }
  }
}
</script>

<style></style>
