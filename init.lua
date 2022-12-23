local cyan   = "\x1b[36m"
local green  = "\x1b[92m"
local normal = "\x1b[m"

-- prompt filter to add repo url in green
local git_repo_prompt = clink.promptfilter(60)
function git_repo_prompt:filter(prompt)
  local line = io.popen("git config --get remote.origin.url"):read("*a")
  local repo = line:match("(.+)\n")
  if repo then
    return prompt .. "\n" .. cyan .. "[" .. repo .. "]" .. normal
  end
end

-- prompt filter to add current branch in cyan
local git_branch_prompt = clink.promptfilter(65)
function git_branch_prompt:filter(prompt)
  local line = io.popen("git branch --show-current 2>nul"):read("*a")
  local branch = line:match("(.+)\n")
  if branch then
    return prompt .. " " .. green .. "(" .. branch .. ")" .. normal
  end
end

-- A prompt filter that adds a line feed and angle bracket.
local bracket_prompt = clink.promptfilter(150)
function bracket_prompt:filter(prompt)
  return prompt .. "\n> "
end
