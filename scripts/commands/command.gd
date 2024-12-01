class_name Command

enum Status {
	ACTIVE,
	DONE,
	ERROR,
}

func execute(_player: CharacterBody2D) -> Status:  # Change Player to CharacterBody2D
	return Status.DONE
