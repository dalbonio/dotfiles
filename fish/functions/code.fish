# Defined in - @ line 1
function code --wraps='nohup code & disown' --wraps='code &>/dev/null' --description 'alias code=code &>/dev/null'
 command code &>/dev/null $argv;
end
