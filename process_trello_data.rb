# Prerequisites:
#   gem install json

require 'json'

SOURCE_FILE = 'mCQAYiAL.json'
OUTPUT_FILE = 'data/process-sections.json'
EXPECTED_ID = '5dbedf15df09908808443d74'
PROTOYPE_LABEL_NAME = 'Prototype'
RESOURCES_LIST_NAME = 'Resources'
CHECKLISTS_LIST_NAME = 'Checklists'

source = JSON.parse(File.read(SOURCE_FILE))

output = {}

abort("Wrong Trello board data - ID should be: '#{EXPECTED_ID}'") if source['id'] != EXPECTED_ID

prototype_label_color = source['labelNames'].key(PROTOYPE_LABEL_NAME)

abort("No '#{PROTOYPE_LABEL_NAME}' label defined in the Trello board data - we need this to determine which data to pick out.") unless prototype_label_color

# Metadata
output['dateLastActivity'] = source['dateLastActivity']

# Now build up the hierarchy for each process section.
#
# Assumptions:
# - Only cards with the "Prototype" label will be used (across ALL lists).
# - The "Resources" list is considered to be the index of all process sections (where one card is one process section).
#   - The name of the process section card is used as the identifier/reference to tie all the other Trello board data together.
#   - The attachments within this process section card will be the set of "resources" used in the prototype.
# - The actual process map/list for each section will be the set of cards from a dedicated list for that section (where the name of the list starts with the name of the section).
# - The checklist for each process section lives in a card in a special "Checklists" list.

lists = source['lists'].select { |l| !l['closed'] }

cards = source['cards'].select do |c|
  !c['closed'] &&
    c['labels'].any? { |l| l['name'] == PROTOYPE_LABEL_NAME }
end

sections = []

sections_list_id = lists.find { |l| l['name'] == RESOURCES_LIST_NAME }['id']

checklists_list_id = lists.find { |l| l['name'] == CHECKLISTS_LIST_NAME }['id']

cards.each do |c|
  if c['idList'] == sections_list_id
    sections << {
      name: c['name'],
      main_card: c
    }
  end
end

sections.each do |s|
  process_section_list = lists.find { |l| l['name'].start_with? s[:name] }
  s[:process_cards] = cards.select { |c| c['idList'] == process_section_list['id'] }

  checklist_card = cards.find do |c|
    c['idList'] == checklists_list_id &&
      c['name'] == "Checklist: #{s[:name]}"
  end

  next unless checklist_card

  s[:checklist] = source['checklists'].find { |c| c['id'] == checklist_card['idChecklists'].first }
end

# Now map the sections Trello data to the final output data we need, and save it.

output['sections'] = sections.map do |s|
  {
    name: s[:name],
    resources: s[:main_card]['attachments'].map do |a|
      {
        name: a['name'],
        url: a['url']
      }
    end,
    processMap: s[:process_cards].map do |c|
      {
        name: c['name'],
        text: c['desc']
      }
    end,
    checklist: if s[:checklist]
      s[:checklist]['checkItems'].map do |i|
        {
          text: i['name']
        }
      end
    else
      []
    end
  }
end

File.open(OUTPUT_FILE, 'w') do |f|
  f.write(JSON.pretty_generate(output))
end
