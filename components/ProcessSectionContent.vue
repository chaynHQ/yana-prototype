<template>
  <div>
    <div v-if="section.processMap && section.processMap.length">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Process
        </v-chip>
      </h3>

      <v-expansion-panels accordion class="process-section-steps">
        <v-expansion-panel
          v-for="(step, index) in section.processMap"
          :key="index"
          class="process-section-step"
        >
          <v-expansion-panel-header
            class="subtitle-2"
            color="transparent"
            @click="scrollToTarget"
          >
            <div class="process-section-step-header">
              {{ step.name }}
            </div>
          </v-expansion-panel-header>
          <v-expansion-panel-content color="transparent">
            <div class="process-section-step-content">
              <vue-simple-markdown
                :source="step.text"
                class="body-2"
              ></vue-simple-markdown>
            </div>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>

    <div v-if="section.resources && section.resources.length" class="mt-4">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Resources
        </v-chip>
      </h3>

      <p class="body-2 px-3 mt-4">
        We’ve tried to break all of the necessary information down into more
        manageable chunks above, however if you’d like to read more in depth
        then you can take a look at these resources.
      </p>

      <ul class="simple-list body-2">
        <li v-for="(resource, index) in section.resources" :key="index">
          <a :href="resource.url" target="_blank" rel="noopener">
            {{ resource.name }}
          </a>
        </li>
      </ul>
    </div>

    <div v-if="section.checklist && section.checklist.length" class="mt-4">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Checklist
        </v-chip>
      </h3>

      <p class="body-2 px-3 mt-4">
        It can be hard to know whether things are progressing as they should. To
        help you be more in control, we’ve created this checklist. Mark events
        that have taken place and raise with the relevant parties if you feel
        any steps were missed.
      </p>

      <ul class="simple-list checklist body-2">
        <li v-for="(item, index) in section.checklist" :key="index">
          <v-checkbox
            v-model="item.done"
            :label="item.text"
            hide-details
            :ripple="false"
          ></v-checkbox>
        </li>
      </ul>

      <div class="mt-3 d-flex justify-center">
        <v-btn color="primary" small @click="downloadChecklist(section)">
          <v-icon left>mdi-pdf-box</v-icon>
          Download checklist
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    section: {
      type: Object,
      required: true
    }
  },
  methods: {
    scrollToTarget(event) {
      if (event) {
        setTimeout(() => this.$vuetify.goTo(event.target), 300)
      }
    },
    downloadChecklist(section) {
      const title = `Checklist - ${section.name}`

      const pdfMake = require('pdfmake/build/pdfmake.js')
      if (pdfMake.vfs === undefined) {
        const pdfFonts = require('pdfmake/build/vfs_fonts.js')
        pdfMake.vfs = pdfFonts.pdfMake.vfs
      }
      const docDefinition = {
        info: {
          title,
          author: 'yana',
          creator: 'yana',
          producer: 'yana',
          subject: 'subject of document',
          keywords: 'Checklist'
        },
        content: [
          { text: 'yana', fontSize: 20, bold: true, lineHeight: 2 },
          {
            text: title,
            fontSize: 16,
            bold: true,
            lineHeight: 1.5
          },
          {
            fontSize: 14,
            lineHeight: 1.5,
            layout: 'noBorders',
            table: {
              widths: [42, 'auto'],
              body: section.checklist.map((i) => {
                return [
                  {
                    image: 'unchecked',
                    width: 14,
                    margin: [14, 16, 14, 0],
                    opacity: 0.7
                  },
                  { text: i.text, margin: [0, 14, 0, 0] }
                ]
              })
            }
          }
        ],
        defaultStyle: {
          color: '#1d2445'
        },
        images: {
          unchecked:
            'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAQAAACROWYpAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAF+2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDAgNzkuMTYwNDUxLCAyMDE3LzA1LzA2LTAxOjA4OjIxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTktMTItMzBUMDE6Mzc6MjArMDE6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDE5LTEyLTMwVDAxOjM4OjU3KzAxOjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDE5LTEyLTMwVDAxOjM4OjU3KzAxOjAwIiBkYzpmb3JtYXQ9ImltYWdlL3BuZyIgcGhvdG9zaG9wOkNvbG9yTW9kZT0iMSIgcGhvdG9zaG9wOklDQ1Byb2ZpbGU9IkRvdCBHYWluIDIwJSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpjMGUyMmJhZC1lY2VkLTQzZWUtYjIzZC1jNDZjOTNiM2UzNWMiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo5M2FhOTEzYy1hZDVmLWZmNGEtOWE5Ny1kMmUwZjdmYzFlYmUiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDozYmY2ODFlMy1hMTRhLTQyODMtOGIxNi0zNjQ4M2E2YmZlNjYiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjNiZjY4MWUzLWExNGEtNDI4My04YjE2LTM2NDgzYTZiZmU2NiIgc3RFdnQ6d2hlbj0iMjAxOS0xMi0zMFQwMTozNzoyMCswMTowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKE1hY2ludG9zaCkiLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmMwZTIyYmFkLWVjZWQtNDNlZS1iMjNkLWM0NmM5M2IzZTM1YyIgc3RFdnQ6d2hlbj0iMjAxOS0xMi0zMFQwMTozODo1NyswMTowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKE1hY2ludG9zaCkiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+6AB6cQAAAPxJREFUOMvF1b1Kw1AYBuAnFf8QL8WlIHQJIriIdyEu4qCTXop7dwenTgUHpYvgJVhob8AuakE+h9hapJqcFDXvFDgPIXlzvgNLjnQ9GlRM340TK7DsUtRI2zqH09txxUzWn3IrhK4DecXs6wjhnqHwZk/K1fIiDAs81krCW54KPBDG8iTcNBIGf4ND1MWTdmrgqIOL5TM0S8SRhmMu1dAo+2DZ57t9eWajtKrvN1GVnrMK9HewhbBy+nPPJbTsJwmymOn8P7fkfLzQGCoG4G4S3vZc4J4QOnY0KyZ3LYQHjqcjf1Qxrx/inDXtWsfNlU1YdeZOP+Gg67mwwTvIDqR1iAowgQAAAABJRU5ErkJggg=='
        }
      }
      pdfMake
        .createPdf(docDefinition)
        .download(`Checklist - ${section.name}.pdf`)
    }
  }
}
</script>

<style></style>
