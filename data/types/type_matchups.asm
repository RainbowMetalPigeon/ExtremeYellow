TypeEffects:
	;  attacker,     defender,     *=
	db WATER,        FIRE,         SUPER_EFFECTIVE
	db WATER,        ROCK,         SUPER_EFFECTIVE
	db WATER,        GROUND,       SUPER_EFFECTIVE
	db WATER,        WATER,        NOT_VERY_EFFECTIVE
	db WATER,        GRASS,        NOT_VERY_EFFECTIVE
	db WATER,        DRAGON,       NOT_VERY_EFFECTIVE

	db FIRE,         GRASS,        SUPER_EFFECTIVE
	db FIRE,         ICE,          SUPER_EFFECTIVE
	db FIRE,         BUG,          SUPER_EFFECTIVE
	db FIRE,         STEEL,        SUPER_EFFECTIVE
	db FIRE,         FIRE,         NOT_VERY_EFFECTIVE
	db FIRE,         WATER,        NOT_VERY_EFFECTIVE
	db FIRE,         ROCK,         NOT_VERY_EFFECTIVE
	db FIRE,         DRAGON,       NOT_VERY_EFFECTIVE

	db GRASS,        WATER,        SUPER_EFFECTIVE
	db GRASS,        GROUND,       SUPER_EFFECTIVE
	db GRASS,        ROCK,         SUPER_EFFECTIVE
	db GRASS,        GRASS,        NOT_VERY_EFFECTIVE
	db GRASS,        FIRE,         NOT_VERY_EFFECTIVE
	db GRASS,        BUG,          NOT_VERY_EFFECTIVE
	db GRASS,        POISON,       NOT_VERY_EFFECTIVE
	db GRASS,        FLYING,       NOT_VERY_EFFECTIVE
	db GRASS,        DRAGON,       NOT_VERY_EFFECTIVE
	db GRASS,        STEEL,        NOT_VERY_EFFECTIVE

	db ELECTRIC,     WATER,        SUPER_EFFECTIVE
	db ELECTRIC,     FLYING,       SUPER_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     NOT_VERY_EFFECTIVE
	db ELECTRIC,     GRASS,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     DRAGON,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     GROUND,       NO_EFFECT

	db ICE,          GRASS,        SUPER_EFFECTIVE
	db ICE,          GROUND,       SUPER_EFFECTIVE
	db ICE,          FLYING,       SUPER_EFFECTIVE
	db ICE,          DRAGON,       SUPER_EFFECTIVE
	db ICE,          ICE,          NOT_VERY_EFFECTIVE
	db ICE,          WATER,        NOT_VERY_EFFECTIVE
	db ICE,          FIRE,         NOT_VERY_EFFECTIVE
	db ICE,          STEEL,        NOT_VERY_EFFECTIVE

	db PSYCHIC_TYPE, FIGHTING,     SUPER_EFFECTIVE
	db PSYCHIC_TYPE, POISON,       SUPER_EFFECTIVE
	db PSYCHIC_TYPE, PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         NO_EFFECT

	db DRAGON,       DRAGON,       SUPER_EFFECTIVE
	db DRAGON,       STEEL,        NOT_VERY_EFFECTIVE
	db DRAGON,       FAIRY,        NO_EFFECT

	db DARK,         PSYCHIC_TYPE, SUPER_EFFECTIVE
	db DARK,         GHOST,        SUPER_EFFECTIVE
	db DARK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db DARK,         FAIRY,        NOT_VERY_EFFECTIVE
	db DARK,         DARK,         NOT_VERY_EFFECTIVE

	db FAIRY,        FIGHTING,     SUPER_EFFECTIVE
	db FAIRY,        DRAGON,       SUPER_EFFECTIVE
	db FAIRY,        DARK,         SUPER_EFFECTIVE
	db FAIRY,        FIRE,         NOT_VERY_EFFECTIVE
	db FAIRY,        POISON,       NOT_VERY_EFFECTIVE
	db FAIRY,        STEEL,        NOT_VERY_EFFECTIVE

	db NORMAL,       ROCK,         NOT_VERY_EFFECTIVE
	db NORMAL,       STEEL,        NOT_VERY_EFFECTIVE
	db NORMAL,       GHOST,        NO_EFFECT

	db GHOST,        GHOST,        SUPER_EFFECTIVE
	db GHOST,        PSYCHIC_TYPE, SUPER_EFFECTIVE
	db GHOST,        DARK,         NOT_VERY_EFFECTIVE
	db GHOST,        NORMAL,       NO_EFFECT

	db FIGHTING,     NORMAL,       SUPER_EFFECTIVE
	db FIGHTING,     ROCK,         SUPER_EFFECTIVE
	db FIGHTING,     ICE,          SUPER_EFFECTIVE
	db FIGHTING,     DARK,         SUPER_EFFECTIVE
	db FIGHTING,     STEEL,        SUPER_EFFECTIVE
	db FIGHTING,     POISON,       NOT_VERY_EFFECTIVE
	db FIGHTING,     FLYING,       NOT_VERY_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db FIGHTING,     BUG,          NOT_VERY_EFFECTIVE
	db FIGHTING,     FAIRY,        NOT_VERY_EFFECTIVE
	db FIGHTING,     GHOST,        NO_EFFECT

	db POISON,       GRASS,        SUPER_EFFECTIVE
	db POISON,       FAIRY,        SUPER_EFFECTIVE
	db POISON,       POISON,       NOT_VERY_EFFECTIVE
	db POISON,       GROUND,       NOT_VERY_EFFECTIVE
	db POISON,       ROCK,         NOT_VERY_EFFECTIVE
	db POISON,       GHOST,        NOT_VERY_EFFECTIVE
	db POISON,       STEEL,        NO_EFFECT

	db FLYING,       FIGHTING,     SUPER_EFFECTIVE
	db FLYING,       BUG,          SUPER_EFFECTIVE
	db FLYING,       GRASS,        SUPER_EFFECTIVE
	db FLYING,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db FLYING,       ROCK,         NOT_VERY_EFFECTIVE
	db FLYING,       STEEL,        NOT_VERY_EFFECTIVE

	db BUG,          GRASS,        SUPER_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, SUPER_EFFECTIVE
	db BUG,          DARK,         SUPER_EFFECTIVE
	db BUG,          POISON,       NOT_VERY_EFFECTIVE
	db BUG,          FIRE,         NOT_VERY_EFFECTIVE
	db BUG,          FIGHTING,     NOT_VERY_EFFECTIVE
	db BUG,          FLYING,       NOT_VERY_EFFECTIVE
	db BUG,          GHOST,        NOT_VERY_EFFECTIVE
	db BUG,          STEEL,        NOT_VERY_EFFECTIVE
	db BUG,          FAIRY,        NOT_VERY_EFFECTIVE

	db GROUND,       FIRE,         SUPER_EFFECTIVE
	db GROUND,       ELECTRIC,     SUPER_EFFECTIVE
	db GROUND,       ROCK,         SUPER_EFFECTIVE
	db GROUND,       POISON,       SUPER_EFFECTIVE
	db GROUND,       STEEL,        SUPER_EFFECTIVE
	db GROUND,       GRASS,        NOT_VERY_EFFECTIVE
	db GROUND,       BUG,          NOT_VERY_EFFECTIVE
	db GROUND,       FLYING,       NO_EFFECT

	; new, for THOUSANDARROWS
	db GROUND2,      FIRE,         SUPER_EFFECTIVE
	db GROUND2,      ELECTRIC,     SUPER_EFFECTIVE
	db GROUND2,      ROCK,         SUPER_EFFECTIVE
	db GROUND2,      POISON,       SUPER_EFFECTIVE
	db GROUND2,      STEEL,        SUPER_EFFECTIVE
	db GROUND2,      GRASS,        NOT_VERY_EFFECTIVE
	db GROUND2,      BUG,          NOT_VERY_EFFECTIVE

	db ROCK,         FIRE,         SUPER_EFFECTIVE
	db ROCK,         FLYING,       SUPER_EFFECTIVE
	db ROCK,         BUG,          SUPER_EFFECTIVE
	db ROCK,         ICE,          SUPER_EFFECTIVE
	db ROCK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db ROCK,         GROUND,       NOT_VERY_EFFECTIVE
	db ROCK,         STEEL,        NOT_VERY_EFFECTIVE

	db STEEL,        ICE,          SUPER_EFFECTIVE
	db STEEL,        ROCK,         SUPER_EFFECTIVE
	db STEEL,        FAIRY,        SUPER_EFFECTIVE
	db STEEL,        FIRE,         NOT_VERY_EFFECTIVE
	db STEEL,        WATER,        NOT_VERY_EFFECTIVE
	db STEEL,        ELECTRIC,     NOT_VERY_EFFECTIVE
	db STEEL,        STEEL,        NOT_VERY_EFFECTIVE

	db -1 ; end

TypeEffectsInverse:
	;  attacker,     defender,     *=
	db WATER,        FIRE,         NOT_VERY_EFFECTIVE
	db WATER,        ROCK,         NOT_VERY_EFFECTIVE
	db WATER,        GROUND,       NOT_VERY_EFFECTIVE
	db WATER,        WATER,        SUPER_EFFECTIVE
	db WATER,        GRASS,        SUPER_EFFECTIVE
	db WATER,        DRAGON,       SUPER_EFFECTIVE

	db FIRE,         GRASS,        NOT_VERY_EFFECTIVE
	db FIRE,         ICE,          NOT_VERY_EFFECTIVE
	db FIRE,         BUG,          NOT_VERY_EFFECTIVE
	db FIRE,         STEEL,        NOT_VERY_EFFECTIVE
	db FIRE,         FIRE,         SUPER_EFFECTIVE
	db FIRE,         WATER,        SUPER_EFFECTIVE
	db FIRE,         ROCK,         SUPER_EFFECTIVE
	db FIRE,         DRAGON,       SUPER_EFFECTIVE

	db GRASS,        WATER,        NOT_VERY_EFFECTIVE
	db GRASS,        GROUND,       NOT_VERY_EFFECTIVE
	db GRASS,        ROCK,         NOT_VERY_EFFECTIVE
	db GRASS,        GRASS,        SUPER_EFFECTIVE
	db GRASS,        FIRE,         SUPER_EFFECTIVE
	db GRASS,        BUG,          SUPER_EFFECTIVE
	db GRASS,        POISON,       SUPER_EFFECTIVE
	db GRASS,        FLYING,       SUPER_EFFECTIVE
	db GRASS,        DRAGON,       SUPER_EFFECTIVE
	db GRASS,        STEEL,        SUPER_EFFECTIVE

	db ELECTRIC,     WATER,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     FLYING,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     SUPER_EFFECTIVE
	db ELECTRIC,     GRASS,        SUPER_EFFECTIVE
	db ELECTRIC,     DRAGON,       SUPER_EFFECTIVE
	db ELECTRIC,     GROUND,       SUPER_EFFECTIVE

	db ICE,          GRASS,        NOT_VERY_EFFECTIVE
	db ICE,          GROUND,       NOT_VERY_EFFECTIVE
	db ICE,          FLYING,       NOT_VERY_EFFECTIVE
	db ICE,          DRAGON,       NOT_VERY_EFFECTIVE
	db ICE,          ICE,          SUPER_EFFECTIVE
	db ICE,          WATER,        SUPER_EFFECTIVE
	db ICE,          FIRE,         SUPER_EFFECTIVE
	db ICE,          STEEL,        SUPER_EFFECTIVE

	db PSYCHIC_TYPE, FIGHTING,     NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, POISON,       NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, PSYCHIC_TYPE, SUPER_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        SUPER_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         SUPER_EFFECTIVE

	db DRAGON,       DRAGON,       NOT_VERY_EFFECTIVE
	db DRAGON,       STEEL,        SUPER_EFFECTIVE
	db DRAGON,       FAIRY,        SUPER_EFFECTIVE

	db DARK,         PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db DARK,         GHOST,        NOT_VERY_EFFECTIVE
	db DARK,         FIGHTING,     SUPER_EFFECTIVE
	db DARK,         FAIRY,        SUPER_EFFECTIVE
	db DARK,         DARK,         SUPER_EFFECTIVE

	db FAIRY,        FIGHTING,     NOT_VERY_EFFECTIVE
	db FAIRY,        DRAGON,       NOT_VERY_EFFECTIVE
	db FAIRY,        DARK,         NOT_VERY_EFFECTIVE
	db FAIRY,        FIRE,         SUPER_EFFECTIVE
	db FAIRY,        POISON,       SUPER_EFFECTIVE
	db FAIRY,        STEEL,        SUPER_EFFECTIVE

	db NORMAL,       ROCK,         SUPER_EFFECTIVE
	db NORMAL,       STEEL,        SUPER_EFFECTIVE
	db NORMAL,       GHOST,        SUPER_EFFECTIVE

	db GHOST,        GHOST,        NOT_VERY_EFFECTIVE
	db GHOST,        PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db GHOST,        DARK,         SUPER_EFFECTIVE
	db GHOST,        NORMAL,       SUPER_EFFECTIVE

	db FIGHTING,     NORMAL,       NOT_VERY_EFFECTIVE
	db FIGHTING,     ROCK,         NOT_VERY_EFFECTIVE
	db FIGHTING,     ICE,          NOT_VERY_EFFECTIVE
	db FIGHTING,     DARK,         NOT_VERY_EFFECTIVE
	db FIGHTING,     STEEL,        NOT_VERY_EFFECTIVE
	db FIGHTING,     POISON,       SUPER_EFFECTIVE
	db FIGHTING,     FLYING,       SUPER_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, SUPER_EFFECTIVE
	db FIGHTING,     BUG,          SUPER_EFFECTIVE
	db FIGHTING,     FAIRY,        SUPER_EFFECTIVE
	db FIGHTING,     GHOST,        SUPER_EFFECTIVE

	db POISON,       GRASS,        NOT_VERY_EFFECTIVE
	db POISON,       FAIRY,        NOT_VERY_EFFECTIVE
	db POISON,       POISON,       SUPER_EFFECTIVE
	db POISON,       GROUND,       SUPER_EFFECTIVE
	db POISON,       ROCK,         SUPER_EFFECTIVE
	db POISON,       GHOST,        SUPER_EFFECTIVE
	db POISON,       STEEL,        SUPER_EFFECTIVE

	db FLYING,       FIGHTING,     NOT_VERY_EFFECTIVE
	db FLYING,       BUG,          NOT_VERY_EFFECTIVE
	db FLYING,       GRASS,        NOT_VERY_EFFECTIVE
	db FLYING,       ELECTRIC,     SUPER_EFFECTIVE
	db FLYING,       ROCK,         SUPER_EFFECTIVE
	db FLYING,       STEEL,        SUPER_EFFECTIVE

	db BUG,          GRASS,        NOT_VERY_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db BUG,          DARK,         NOT_VERY_EFFECTIVE
	db BUG,          POISON,       SUPER_EFFECTIVE
	db BUG,          FIRE,         SUPER_EFFECTIVE
	db BUG,          FIGHTING,     SUPER_EFFECTIVE
	db BUG,          FLYING,       SUPER_EFFECTIVE
	db BUG,          GHOST,        SUPER_EFFECTIVE
	db BUG,          STEEL,        SUPER_EFFECTIVE
	db BUG,          FAIRY,        SUPER_EFFECTIVE

	db GROUND,       FIRE,         NOT_VERY_EFFECTIVE
	db GROUND,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND,       ROCK,         NOT_VERY_EFFECTIVE
	db GROUND,       POISON,       NOT_VERY_EFFECTIVE
	db GROUND,       STEEL,        NOT_VERY_EFFECTIVE
	db GROUND,       GRASS,        SUPER_EFFECTIVE
	db GROUND,       BUG,          SUPER_EFFECTIVE
	db GROUND,       FLYING,       SUPER_EFFECTIVE

	; new, for THOUSANDARROWS
	db GROUND2,      FIRE,         NOT_VERY_EFFECTIVE
	db GROUND2,      ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND2,      ROCK,         NOT_VERY_EFFECTIVE
	db GROUND2,      POISON,       NOT_VERY_EFFECTIVE
	db GROUND2,      STEEL,        NOT_VERY_EFFECTIVE
	db GROUND2,      GRASS,        SUPER_EFFECTIVE
	db GROUND2,      BUG,          SUPER_EFFECTIVE
	db GROUND2,      FLYING,       SUPER_EFFECTIVE


	db ROCK,         FIRE,         NOT_VERY_EFFECTIVE
	db ROCK,         FLYING,       NOT_VERY_EFFECTIVE
	db ROCK,         BUG,          NOT_VERY_EFFECTIVE
	db ROCK,         ICE,          NOT_VERY_EFFECTIVE
	db ROCK,         FIGHTING,     SUPER_EFFECTIVE
	db ROCK,         GROUND,       SUPER_EFFECTIVE
	db ROCK,         STEEL,        SUPER_EFFECTIVE

	db STEEL,        ICE,          NOT_VERY_EFFECTIVE
	db STEEL,        ROCK,         NOT_VERY_EFFECTIVE
	db STEEL,        FAIRY,        NOT_VERY_EFFECTIVE
	db STEEL,        FIRE,         SUPER_EFFECTIVE
	db STEEL,        WATER,        SUPER_EFFECTIVE
	db STEEL,        ELECTRIC,     SUPER_EFFECTIVE
	db STEEL,        STEEL,        SUPER_EFFECTIVE

	db -1 ; end
