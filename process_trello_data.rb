# Prerequisites:
#   gem install json

require 'json'

SOURCE_FILE = 'mCQAYiAL.json'
OUTPUT_FILE = 'data/process-map.json'
EXPECTED_ID = '5dbedf15df09908808443d74'
PROTOYPE_LABEL_VALUE = 'Prototype'
CHECKLISTS_LIST_NAME = 'Checklists'

source = JSON.parse(File.read(SOURCE_FILE))

output = {}

abort("Wrong Trello board data - ID should be: '#{EXPECTED_ID}'") if source['id'] != EXPECTED_ID

prototype_label = source['labelNames'].key(PROTOYPE_LABEL_VALUE)

abort("No '#{PROTOYPE_LABEL_VALUE}' label defined in the Trello board data - we need this to determine which checklists to use.") if prototype_label == nil

# Metadata
output['dateLastActivity'] = source['dateLastActivity']

# The first list is considered to the the index of all process sections.
sections_list_id = source['lists'].first['id']

# Checklists are stored in a special list.
checklists_list_id = source['lists'].find { |l| l['name'] == CHECKLISTS_LIST_NAME }['id']

# Now build up the hierarchy for each process section.

temp_sections = []

# Get the cards representing the individual process sections; the name will be the reference we use to tie all the data together.
source['cards'].each do |c|
  if c['idList'] == sections_list_id
    temp_sections << {
      name: c['name'],
      main_card: c
    }
  end
end


# Now map the temp hierarchy to the final output data we need, and save it.

output['sections'] = temp_sections.map do |s|
  {
    name: s[:name]
  }
end

File.open(OUTPUT_FILE, 'w') do |f|
  f.write(JSON.pretty_generate(output))
end
