class_name Command

enum Status {
	ACTIVE,
	DONE,
	ERROR,
}


func execute(_player: CharacterBody2D) -> Status:
	return Status.DONE
