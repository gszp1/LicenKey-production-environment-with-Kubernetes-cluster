#!/bin/bash
ENTRY_SCRIPT="playbooks.sh"
PLAYBOOKS_SCRIPT="new_playbooks.sh"
if [[ ! -f "$ENTRY_SCRIPT" || ! -f "$PLAYBOOKS_SCRIPT" ]]; then
    echo "One of the scripts does not exist."
    exit 1;
fi

if [[ -n $(tail -c1 "$ENTRY_SCRIPT") ]]; then
    echo >> "$ENTRY_SCRIPT"
fi

tail -n +3 "$PLAYBOOKS_SCRIPT" >> "$ENTRY_SCRIPT"
echo -e "#!/bin/bash\n# DO NOT ENTER ANY EXTRA SPAPCES, NEW LINES OR OTHER COMMANDS BETWEEN, AFTER OR BEFORE PLAYBOOK CALLS" > "$PLAYBOOKS_SCRIPT"
echo "Playbook commands moved from $PLAYBOOKS_SCRIPT to $ENTRY_SCRIPT."