<template>
  <!-- Inspired by: https://github.com/rymbau/breath-focus -->

  <div
    class="breathing-exercise d-flex flex-column justify-center align-content-space-between elevation-1"
  >
    <p class="title text-center">
      <v-fade-transition hide-on-leave>
        <span :key="`message-${message}`">
          {{ message }}
        </span>
      </v-fade-transition>
    </p>

    <div class="breath">
      <div ref="breathContent" class="breath-content"></div>
    </div>

    <div class="mt-3 d-flex flex-column justify-center align-center">
      <v-fade-transition hide-on-leave>
        <v-btn v-if="!running" outlined color="primary" @click="start">
          Start
        </v-btn>

        <div v-else class="title text-center" refs="countdown">
          <v-fade-transition leave-absolute>
            <span :key="`timer-message-${timerMessage}`">
              {{ timerMessage }}
            </span>
          </v-fade-transition>
        </div>
      </v-fade-transition>
    </div>
  </div>
</template>

<script>
const INITIAL_MESSAGE = 'Get comfortable and start breathing when ready'

export default {
  data() {
    return {
      breathTimeMins: 1,
      breathStepMs: 5000,
      breathInterval: null,
      stepInterval: null,
      running: false,
      message: null,
      currentTimerDurationSecs: null,
      timerMessage: null
    }
  },
  mounted() {
    this.setAnimationState('paused')
    this.setAnimationDuration()
    this.resetMessage()
  },
  beforeDestroy() {
    this.clearIntervals()
  },
  methods: {
    start() {
      this.toggleMessage()

      this.stepInterval = setInterval(() => {
        this.toggleMessage()
      }, this.breathStepMs)

      this.startTimer(this.breathTimeMins * 60)

      this.setAnimationState('running')

      this.running = true
    },
    setAnimationState(state) {
      document.body.style.WebkitAnimationPlayState = state
      this.$refs.breathContent.style.WebkitAnimationPlayState = state

      document.body.style.animationPlayState = state
      this.$refs.breathContent.style.animationPlayState = state
    },
    setAnimationDuration() {
      const duration = ((this.breathStepMs * 2) / 1000).toString() + 's'
      this.$refs.breathContent.style.WebkitAnimationDuration = duration
      this.$refs.breathContent.style.animationDuration = duration
    },
    resetMessage() {
      this.message = INITIAL_MESSAGE
    },
    toggleMessage() {
      if (!this.message || this.message === 'Breathe Out') {
        this.message = 'Breathe In'
      } else {
        this.message = 'Breathe Out'
      }
    },
    startTimer(duration) {
      this.currentTimerDurationSecs = duration

      this.breathStep()

      this.breathInterval = setInterval(() => this.breathStep(), 1000)
    },
    breathStep() {
      this.updateTimerMessage()

      if (--this.currentTimerDurationSecs < 0) {
        this.clearIntervals()
        this.setAnimationState('paused')
        this.resetMessage()

        this.running = false
      }
    },
    updateTimerMessage() {
      const minutes = Math.floor(this.currentTimerDurationSecs / 60)
      const seconds = this.currentTimerDurationSecs % 60

      const formatted =
        minutes.toString().padStart(2, '0') +
        ':' +
        seconds.toString().padStart(2, '0')

      this.timerMessage = formatted
    },
    clearIntervals() {
      if (this.breathInterval) {
        clearInterval(this.breathInterval)
      }
      if (this.stepInterval) {
        clearInterval(this.stepInterval)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.breathing-exercise {
  border-radius: 4px;
  width: 100%;
  max-width: 360px;
  margin-left: auto;
  margin-right: auto;
  padding: 1.33em;
  background-color: rgba(white, 0.85);
  letter-spacing: 1px;
  -webkit-animation: bgcolor 10s infinite ease-in-out;
  animation: bgcolor 10s infinite ease-in-out;
  -webkit-animation-play-state: paused;
  animation-play-state: paused;
}

.breath {
  width: 260px;
  height: 260px;
  margin: 10px auto;
  padding: 10px;
  background-color: #d5ecf4;
  border-radius: 50%;
  box-sizing: border-box;
  -webkit-animation: bgcolor2 10s infinite ease-in-out;
  animation: bgcolor2 10s infinite ease-in-out;
}

.breath-content {
  width: 240px;
  height: 240px;
  margin: 0 auto;
  background-color: #eeb15c;
  border-radius: 50%;

  -webkit-transform: scale(0.1);
  transform: scale(0.1);
  -webkit-animation: scale 10s infinite ease-in-out;
  animation: scale 10s infinite ease-in-out;
  -webkit-animation-play-state: paused;
  animation-play-state: paused;

  -webkit-transform-origin: 50% 50%;
  transform-origin: 50% 50%;
}

@-webkit-keyframes scale {
  50% {
    background-color: #eda644;
    -webkit-transform: scale(1);
  }
}

@keyframes scale {
  50% {
    background-color: #eda644;
    transform: scale(1);
  }
}

@-webkit-keyframes bgcolor {
  50% {
    background-color: #d4e4f4;
  }
}

@keyframes bgcolor {
  50% {
    background-color: #d4e4f4;
  }
}

@-webkit-keyframes bgcolor2 {
  50% {
    background-color: #c3def4;
  }
}

@keyframes bgcolor2 {
  50% {
    background-color: #c3def4;
  }
}
</style>
