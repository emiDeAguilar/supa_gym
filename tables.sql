    create table users (
    id uuid primary key default gen_random_uuid(),
    username text not null,
    email text unique not null,
    birth_date date,
    gender text,
    active boolean default true,
    created_at timestamp default now(),
    updated_at timestamp default now()
);

-- EXERCISES (CATALOG)
create table exercises (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    type text,
    active_muscles text,
    created_at timestamp default now()
);

-- ROUTINES (PLAN)
create table routines (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null,
    name text not null,
    objective_type text,
    active boolean default true,
    created_at timestamp default now(),
    updated_at timestamp default now(),

    constraint fk_routines_user
        foreign key (user_id)
        references users(id)
        on delete cascade
);

-- ROUTINE_EXERCISES (PLAN DETAIL)
create table routine_exercises (
    id uuid primary key default gen_random_uuid(),
    routine_id uuid not null,
    exercise_id uuid not null,

    "order" int not null,
    target_sets int,
    target_reps int,
    rest_seconds int,
    target_weight numeric(6,2),

    constraint fk_re_routine
        foreign key (routine_id)
        references routines(id)
        on delete cascade,

    constraint fk_re_exercise
        foreign key (exercise_id)
        references exercises(id)
        on delete cascade
);

-- WORKOUTS (SESSION)
create table workouts (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null,
    routine_id uuid,
    started_at timestamp not null default now(),
    ended_at timestamp,
    notes text,

    constraint fk_workout_user
        foreign key (user_id)
        references users(id)
        on delete cascade,

    constraint fk_workout_routine
        foreign key (routine_id)
        references routines(id)
        on delete set null
);

-- WORKOUT_EXERCISES (EXECUTION DETAIL)
create table workout_exercises (
    id uuid primary key default gen_random_uuid(),
    workout_id uuid not null,
    exercise_id uuid not null,
    routine_exercise_id uuid,
    "order" int,

    constraint fk_we_workout
        foreign key (workout_id)
        references workouts(id)
        on delete cascade,

    constraint fk_we_exercise
        foreign key (exercise_id)
        references exercises(id)
        on delete cascade,

    constraint fk_we_routine_exercise
        foreign key (routine_exercise_id)
        references routine_exercises(id)
        on delete set null
);

-- LOGS (SETS)
create table logs (
    id uuid primary key default gen_random_uuid(),
    workout_exercise_id uuid not null,
    set_number int not null,
    reps int not null,
    weight numeric(6,2),

    constraint fk_logs_we
        foreign key (workout_exercise_id)
        references workout_exercises(id)
        on delete cascade,

    constraint unique_set_per_exercise
        unique (workout_exercise_id, set_number)
);