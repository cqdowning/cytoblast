class_name Command
## Command for a player action
##
## Can execute an action on the player
## Returns a status

enum Status {
	ACTIVE,
	DONE,
	ERROR,
}


func execute(_player: CharacterBody2D) -> Status:
	return Status.DONE
