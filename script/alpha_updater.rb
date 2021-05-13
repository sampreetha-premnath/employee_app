ENGLISH_YAML_FILE_PATH = "config/locales/en.yml"
ALPHA_YAML_FILE_PATH = "config/locales/alpha.yml"

ALPHA_CONTENT_SCORE = 2

def get_git_status_lines_cmd(file, staged = true)
  cmd = ""
  #Fetch Git Diff
  cmd += "git diff"
  #Fetch only the corresponding change lines
  cmd += " --unified=0"
  #Fetch changes from staged file
  cmd += " --cached" if staged
  #Add the file name
  cmd += " -- '#{file}'"
  #Fetch data between @@
  cmd += " | awk '/@@/'"
  #Split the results based on Space
  cmd += " | cut -d' '"
  #Display 3rd and 2nd column of result
  cmd += " -f3 -f2"
  cmd
end

def hard_reset_file(file)
  `git checkout HEAD -- #{file}`
end

def stage_file(file)
  `git add #{file}`
end

def get_git_status_lines(file)
  cmd = get_git_status_lines_cmd(file)
  result = `#{cmd}`
  if result.empty?
    cmd = get_git_status_lines_cmd(file, false)
    result = `#{cmd}`
  end
  result.split("\n")
end

def add_actions(actions,type,value)
  multiline = value.include?(",")
  if(multiline)
    res = value.split(",")
    line_num = res[0].to_i
    count = res[1].to_i
    count.times { |i| actions[type].push(line_num + i )	}
  else
    actions[type].push(value.to_i)
  end
end

def get_clone_actions(file)
  actions = { delete: [], copy: []}
  lines = get_git_status_lines(file)
  lines.each do |line|
    values = line.split(" ")
    values.each do |value|
      operation = value.slice!(0)
      case operation
      when "-"
        add_actions(actions,:delete,value)
      when "+"
        add_actions(actions,:copy,value)
      end
    end
  end
  actions
end


def update_alpha_file(actions)
  hard_reset_file(ALPHA_YAML_FILE_PATH)
  #Delete lines
  file_lines = ""
  File.open(ALPHA_YAML_FILE_PATH).each_with_index do |line, index|
    file_lines += line unless actions[:delete].index(index+1)
  end

  File.open(ALPHA_YAML_FILE_PATH, 'w') do |file|
    file.puts file_lines
  end

  #Copy lines
  copied_lines = {}
  File.open(ENGLISH_YAML_FILE_PATH).each_with_index do |line, index|
    copied_lines[index+1] = get_alpha_line(line) if actions[:copy].index(index+1)
  end

  file_lines = ""
  line_counter = 0
  File.open(ALPHA_YAML_FILE_PATH).each_with_index do |line|
    line_counter += 1
    while actions[:copy].index(line_counter)
      file_lines += copied_lines[line_counter]
      line_counter += 1
    end
    file_lines += line
  end

  File.open(ALPHA_YAML_FILE_PATH, 'w') do |file|
    file.puts file_lines
  end

  stage_file(ALPHA_YAML_FILE_PATH)
end

def create_alpha_file_and_stage
  file_lines = ""
  File.open(ENGLISH_YAML_FILE_PATH).each_with_index do |line, index|
    if line.eql?("en:\n")
      file_lines += "alpha:\n"
    elsif line.strip.eql?("language_name: 'English'")
      spaces = get_front_space_count(line)
      file_lines += " " * spaces + "language_name: 'Alpha'\n"
    else
      file_lines += get_alpha_line(line)
    end
  end

  File.open(ALPHA_YAML_FILE_PATH, 'w') do |file|
    file.puts file_lines
  end

  stage_file(ALPHA_YAML_FILE_PATH)

  p "alpha.yml is updated and staged succesfully"
end

def generate_alpha_content(value, score = ALPHA_CONTENT_SCORE)
  result = ""
  content = value.strip
  if content.length == 0 || content == "|-" || content == "\"" || content == "'"
    result = value
  elsif content[0] == "#"
    result = value.strip
  else
    space_cnt = get_front_space_count(value)
    actual_size = content.length
    exp_alpha_size = (actual_size * score).to_i
    diff_size = exp_alpha_size - actual_size
    if diff_size > 2
      #Make diff size by 2 and make it to even
      diff_size += (diff_size % 2) - 2
      dollar_count = diff_size / 2
      #Append N $ char in prefix and suffix
      content = "$" * dollar_count + content + "$" * dollar_count
    end
    #Add spaces and Append @ to beginning and end
    result = " " * space_cnt + "^#{content}^"
  end
  result
end

def get_front_space_count(line)
  res = 0
  if line && line.length > 0
    act_length = line.length
    res = act_length - line.lstrip.length
  end
  res
end

def get_alpha_content(line)
  line = line.to_s
  line.gsub!(/\n/,"")
  quote = ""
  attach_quote = line[-1] == "\"" || line[-1] == "'"
  quote = line.slice!(line.length-1) if attach_quote
  space_cnt = get_front_space_count(line)
  alpha_content = " " * space_cnt
  flag = true
  while line.length > 0
    s_index = flag ? line.index("\<") : line.index("\>")
    if s_index
      if flag && s_index > 0
        alpha_content += generate_alpha_content(line.slice!(0,s_index)).to_s
      elsif !flag && s_index > 0
        alpha_content += line.slice!(0,s_index+1).strip
      end
      flag = !flag
    else
      alpha_content += generate_alpha_content(line).to_s
      line = ""
    end
  end
  alpha_content += quote if attach_quote
  alpha_content
end

def is_key?(key)
  !((key.include?("<") || key.include?(">")) && (!key.include?(" ") || (key[0] == "\"" && key[-1] == "\"" || key[0] == "'" && key[-1] =="\"")))
end

def get_alpha_line(line)
  key_pos = line.index(":")
  if key_pos.to_i > 0
    key = line[0,key_pos].strip.to_s
    return get_alpha_content(line) + "\n" unless is_key?(key)
    alpha_line = ""
    quote = ""
    alpha_line += line[0,key_pos+1]
    content = line[key_pos+1..-1].strip
    attach_quote = content[0].eql?("\"") || content[0].eql?("'")
    quote = content.slice!(0,1) if attach_quote
    alpha_line += " " + quote + get_alpha_content(content)
    alpha_line += "\n"
    return alpha_line
  else
    get_alpha_content(line) + "\n"
  end
end

def perform_alpha_file_update_and_stage
  actions = get_clone_actions(ENGLISH_YAML_FILE_PATH)
  if actions[:delete].empty? && actions[:copy].empty?
    p "No changes detected in en.yml."
  else
    update_alpha_file(actions)
    p "alpha.yml is updated and staged succesfully"
  end
end


#perform_alpha_file_update_and_stage
create_alpha_file_and_stage