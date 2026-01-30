DROP TABLE IF EXISTS actores_reparto;
DROP TABLE IF EXISTS actores;
DROP TABLE IF EXISTS teleseries;

CREATE TABLE actores (
    id_actor SERIAL PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE teleseries (
    id_teleserie SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE actores_reparto (
    id_reparto SERIAL PRIMARY KEY,
    id_actor INT NOT NULL,
    id_teleserie INT NOT NULL,
    temporadas INT,
    capitulos INT,
    protagonico BOOLEAN,
    sueldo INT NOT NULL,

    CONSTRAINT fk_actor
        FOREIGN KEY (id_actor)
        REFERENCES actores(id_actor),

    CONSTRAINT fk_teleserie
        FOREIGN KEY (id_teleserie)
        REFERENCES teleseries(id_teleserie),

    CONSTRAINT unq_actor_teleserie
        UNIQUE (id_actor, id_teleserie)
);
