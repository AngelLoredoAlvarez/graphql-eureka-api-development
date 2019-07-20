toc.dat                                                                                             0000600 0004000 0002000 00000361726 13504460374 0014464 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP           ;                w           eureka    11.4    11.4 �    �	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         �	           1262    17756    eureka    DATABASE     x   CREATE DATABASE eureka WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_MX.UTF-8' LC_CTYPE = 'es_MX.UTF-8';
    DROP DATABASE eureka;
             eureka_administrador    false         �	           0    0    DATABASE eureka    ACL     9   REVOKE CONNECT,TEMPORARY ON DATABASE eureka FROM PUBLIC;
                  eureka_administrador    false    2473                     2615    17758    eureka_private    SCHEMA        CREATE SCHEMA eureka_private;
    DROP SCHEMA eureka_private;
             eureka_administrador    false                     2615    17757    eureka_public    SCHEMA        CREATE SCHEMA eureka_public;
    DROP SCHEMA eureka_public;
             eureka_administrador    false                     2615    19087    postgraphile_watch    SCHEMA     "   CREATE SCHEMA postgraphile_watch;
     DROP SCHEMA postgraphile_watch;
             eureka_administrador    false                     3079    17759    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                  false         �	           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                       false    3                     3079    17796    unaccent 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;
    DROP EXTENSION unaccent;
                  false         �	           0    0    EXTENSION unaccent    COMMENT     P   COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';
                       false    2         �           1247    17963 	   jwt_token    TYPE     N   CREATE TYPE eureka_private.jwt_token AS (
	role text,
	id_employee integer
);
 $   DROP TYPE eureka_private.jwt_token;
       eureka_private       eureka_administrador    false    12                    1247    18131    contact    TYPE     L   CREATE TYPE eureka_public.contact AS (
	type_contact text,
	contact text
);
 !   DROP TYPE eureka_public.contact;
       eureka_public       eureka_administrador    false    7         �           1247    17974    privileges_module    TYPE     S   CREATE TYPE eureka_public.privileges_module AS (
	module text,
	privileges text
);
 +   DROP TYPE eureka_public.privileges_module;
       eureka_public       eureka_administrador    false    7         �            1259    17884    employee    TABLE     U  CREATE TABLE eureka_public.employee (
    id integer NOT NULL,
    name text NOT NULL,
    first_name text NOT NULL,
    last_name text,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
 #   DROP TABLE eureka_public.employee;
       eureka_public         eureka_administrador    false    7         �            1259    17926    employee_user    TABLE     �   CREATE TABLE eureka_public.employee_user (
    id integer NOT NULL,
    username text NOT NULL,
    role text NOT NULL,
    id_employee integer NOT NULL
);
 (   DROP TABLE eureka_public.employee_user;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE employee_user    COMMENT     =   COMMENT ON TABLE eureka_public.employee_user IS '@omit all';
            eureka_public       eureka_administrador    false    211         �           1247    17977    current_employee    TYPE     �   CREATE TYPE eureka_public.current_employee AS (
	employee eureka_public.employee,
	employee_user eureka_public.employee_user,
	privileges_modules eureka_public.privileges_module[]
);
 *   DROP TYPE eureka_public.current_employee;
       eureka_public       eureka_administrador    false    7    208    211    746                    1247    18134    role_privileges    TYPE     e   CREATE TYPE eureka_public.role_privileges AS (
	module text,
	add_modify boolean,
	delete boolean
);
 )   DROP TYPE eureka_public.role_privileges;
       eureka_public       eureka_administrador    false    7                    1247    18125    selected_employee    TYPE     �   CREATE TYPE eureka_public.selected_employee AS (
	employee eureka_public.employee,
	employee_user eureka_public.employee_user
);
 +   DROP TYPE eureka_public.selected_employee;
       eureka_public       eureka_administrador    false    7    208    211                    1247    18184    selected_role    TYPE     o   CREATE TYPE eureka_public.selected_role AS (
	role_name text,
	privileges eureka_public.privileges_module[]
);
 '   DROP TYPE eureka_public.selected_role;
       eureka_public       eureka_administrador    false    7    746         �            1259    18094    client_contract_movement    TABLE     �   CREATE TABLE eureka_public.client_contract_movement (
    date timestamp with time zone NOT NULL,
    movement text NOT NULL,
    id_contract integer
);
 3   DROP TABLE eureka_public.client_contract_movement;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE client_contract_movement    COMMENT     H   COMMENT ON TABLE eureka_public.client_contract_movement IS '@omit all';
            eureka_public       eureka_administrador    false    224         !           1255    18120 &   all_client_contract_movements(integer)    FUNCTION     J  CREATE FUNCTION eureka_public.all_client_contract_movements(id_contract integer) RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE STRICT
    AS $_$
    SELECT 
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        id_contract = $1
    ORDER BY
        date
    DESC;
$_$;
 P   DROP FUNCTION eureka_public.all_client_contract_movements(id_contract integer);
       eureka_public       eureka_administrador    false    7    224         �            1259    18037    client_contract    TABLE     �  CREATE TABLE eureka_public.client_contract (
    id integer NOT NULL,
    business text NOT NULL,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    id_type_contract integer NOT NULL,
    start_date timestamp with time zone DEFAULT now(),
    end_date timestamp with time zone NOT NULL,
    status text NOT NULL,
    id_client integer NOT NULL
);
 *   DROP TABLE eureka_public.client_contract;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE client_contract    COMMENT     ?   COMMENT ON TABLE eureka_public.client_contract IS '@omit all';
            eureka_public       eureka_administrador    false    222         E           1255    18121    all_client_contracts(integer)    FUNCTION     0  CREATE FUNCTION eureka_public.all_client_contracts(id_client integer) RETURNS SETOF eureka_public.client_contract
    LANGUAGE sql STABLE STRICT
    AS $_$
    SELECT
        *
    FROM
        eureka_public.client_contract
    WHERE
        id_client = $1
    ORDER BY
        start_date
    DESC;
$_$;
 E   DROP FUNCTION eureka_public.all_client_contracts(id_client integer);
       eureka_public       eureka_administrador    false    222    7                    1255    18122    all_clients_debts()    FUNCTION     3  CREATE FUNCTION eureka_public.all_clients_debts() RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE
    AS $$
    SELECT
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        movement
    LIKE
        'Adeudo'
    ORDER BY
        date
    DESC;
$$;
 1   DROP FUNCTION eureka_public.all_clients_debts();
       eureka_public       eureka_administrador    false    224    7         H           1255    18110    all_contracts_to_pay()    FUNCTION     b  CREATE FUNCTION eureka_public.all_contracts_to_pay() RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE
    AS $$
    SELECT
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        DATE(date) = DATE(NOW())
    AND
        movement
    LIKE
        'Por Pagar'
    ORDER BY
        date
    DESC;
$$;
 4   DROP FUNCTION eureka_public.all_contracts_to_pay();
       eureka_public       eureka_administrador    false    224    7         (           1255    18128    all_roles()    FUNCTION     r  CREATE FUNCTION eureka_public.all_roles() RETURNS SETOF text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        row RECORD;
    BEGIN
        FOR row IN 
            SELECT usename FROM pg_user WHERE usename ILIKE ('%' || 'eureka_' || '%') ORDER BY usename ASC
        LOOP
            RETURN NEXT row.usename;
        END LOOP;

        RETURN; 
    END;
$$;
 )   DROP FUNCTION eureka_public.all_roles();
       eureka_public       eureka_administrador    false    7                    1255    17971    authenticate(text, text)    FUNCTION     �  CREATE FUNCTION eureka_public.authenticate(username text, password text) RETURNS eureka_private.jwt_token
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        role TEXT;
        id_employee INTEGER;
        password_hash TEXT;
    BEGIN
        SELECT
            eureka_public.employee_user.role,
            eureka_public.employee_user.id_employee,
            eureka_private.employee_user_password.password_hash
        INTO
            role,
            id_employee,
            password_hash
        FROM
            eureka_public.employee_user
        INNER JOIN
            eureka_private.employee_user_password
        ON
            eureka_public.employee_user.id = eureka_private.employee_user_password.id_employee_user
        WHERE
            eureka_public.employee_user.username
        LIKE
            $1;

        IF password_hash = CRYPT($2, password_hash) THEN
            RETURN (role, id_employee)::eureka_private.jwt_token;
        ELSE
            RETURN NULL;
        END IF;
    END;
$_$;
 H   DROP FUNCTION eureka_public.authenticate(username text, password text);
       eureka_public       eureka_administrador    false    743    7         ;           1255    18135    charge_month(integer)    FUNCTION       CREATE FUNCTION eureka_public.charge_month(id_contract integer) RETURNS eureka_public.client_contract_movement
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.client_contract
    SET
        status = 'Activo'
    WHERE
        id = $1;

    UPDATE
        eureka_public.client_contract_movement
    SET
        date = NOW(),
        movement = 'Pagado'
    WHERE
        TO_CHAR(date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY')
    AND
        id_contract = $1
    RETURNING
        *;
$_$;
 ?   DROP FUNCTION eureka_public.charge_month(id_contract integer);
       eureka_public       eureka_administrador    false    7    224         2           1255    18114 @   client_contract_formated_end_date(eureka_public.client_contract)    FUNCTION     �   CREATE FUNCTION eureka_public.client_contract_formated_end_date(contract eureka_public.client_contract) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract.end_date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;
 g   DROP FUNCTION eureka_public.client_contract_formated_end_date(contract eureka_public.client_contract);
       eureka_public       eureka_administrador    false    7    222         *           1255    18113 B   client_contract_formated_start_date(eureka_public.client_contract)    FUNCTION     �   CREATE FUNCTION eureka_public.client_contract_formated_start_date(contract eureka_public.client_contract) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract.start_date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;
 i   DROP FUNCTION eureka_public.client_contract_formated_start_date(contract eureka_public.client_contract);
       eureka_public       eureka_administrador    false    7    222         :           1255    18112 ;   client_contract_full_address(eureka_public.client_contract)    FUNCTION     �  CREATE FUNCTION eureka_public.client_contract_full_address(client_contract_table eureka_public.client_contract) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.client_contract.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.client_contract
        ON
            eureka_public.town.id = eureka_public.client_contract.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.client_contract.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.client_contract.id_street
        WHERE
            eureka_public.client_contract.id = client_contract_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;
 o   DROP FUNCTION eureka_public.client_contract_full_address(client_contract_table eureka_public.client_contract);
       eureka_public       eureka_administrador    false    222    7                    1255    18115 W   client_contract_movement_formated_movement_date(eureka_public.client_contract_movement)    FUNCTION       CREATE FUNCTION eureka_public.client_contract_movement_formated_movement_date(contract_movement eureka_public.client_contract_movement) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract_movement.date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;
 �   DROP FUNCTION eureka_public.client_contract_movement_formated_movement_date(contract_movement eureka_public.client_contract_movement);
       eureka_public       eureka_administrador    false    7    224         �            1259    18023    client_contract_type    TABLE       CREATE TABLE eureka_public.client_contract_type (
    id integer NOT NULL,
    type_name text NOT NULL,
    number_months integer NOT NULL,
    month_price numeric NOT NULL,
    tax_type text NOT NULL,
    tax_percentage numeric NOT NULL,
    discount_percentage numeric NOT NULL
);
 /   DROP TABLE eureka_public.client_contract_type;
       eureka_public         eureka_administrador    false    7         �	           0    0 *   COLUMN client_contract_type.tax_percentage    COMMENT     P   COMMENT ON COLUMN eureka_public.client_contract_type.tax_percentage IS '@omit';
            eureka_public       eureka_administrador    false    220         �	           0    0 /   COLUMN client_contract_type.discount_percentage    COMMENT     U   COMMENT ON COLUMN eureka_public.client_contract_type.discount_percentage IS '@omit';
            eureka_public       eureka_administrador    false    220                     1255    18119 L   client_contract_type_discount_percentage(eureka_public.client_contract_type)    FUNCTION     �   CREATE FUNCTION eureka_public.client_contract_type_discount_percentage(contract_type eureka_public.client_contract_type) RETURNS numeric
    LANGUAGE sql STABLE
    AS $$
    SELECT FLOOR(contract_type.discount_percentage * 100);
$$;
 x   DROP FUNCTION eureka_public.client_contract_type_discount_percentage(contract_type eureka_public.client_contract_type);
       eureka_public       eureka_administrador    false    220    7                    1255    18118 G   client_contract_type_tax_percentage(eureka_public.client_contract_type)    FUNCTION     �   CREATE FUNCTION eureka_public.client_contract_type_tax_percentage(contract_type eureka_public.client_contract_type) RETURNS numeric
    LANGUAGE sql STABLE
    AS $$
    SELECT FLOOR(contract_type.tax_percentage * 100);
$$;
 s   DROP FUNCTION eureka_public.client_contract_type_tax_percentage(contract_type eureka_public.client_contract_type);
       eureka_public       eureka_administrador    false    220    7                    1255    18111 >   client_contract_type_total(eureka_public.client_contract_type)    FUNCTION     �  CREATE FUNCTION eureka_public.client_contract_type_total(type_contract eureka_public.client_contract_type) RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        sub_total NUMERIC;
        iva NUMERIC;
        monthly_payment NUMERIC;
    BEGIN
        IF type_contract.discount_percentage > 0 THEN
            sub_total := ((type_contract.number_months * type_contract.month_price) * type_contract.discount_percentage);
        ELSE
            sub_total := (type_contract.number_months * type_contract.month_price);
        END IF;

        iva := sub_total * type_contract.tax_percentage;
        monthly_payment := ROUND(sub_total + iva, 2);

        RETURN monthly_payment;
    END;
$$;
 j   DROP FUNCTION eureka_public.client_contract_type_total(type_contract eureka_public.client_contract_type);
       eureka_public       eureka_administrador    false    220    7         �            1259    17981    client    TABLE     S  CREATE TABLE eureka_public.client (
    id integer NOT NULL,
    name text NOT NULL,
    first_name text NOT NULL,
    last_name text,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
 !   DROP TABLE eureka_public.client;
       eureka_public         eureka_administrador    false    7         F           1255    18116 )   client_full_address(eureka_public.client)    FUNCTION     D  CREATE FUNCTION eureka_public.client_full_address(client_table eureka_public.client) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.client.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.client
        ON
            eureka_public.town.id = eureka_public.client.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.client.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.client.id_street
        WHERE
            eureka_public.client.id = client_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;
 T   DROP FUNCTION eureka_public.client_full_address(client_table eureka_public.client);
       eureka_public       eureka_administrador    false    7    217         "           1255    18117 &   client_full_name(eureka_public.client)    FUNCTION     �   CREATE FUNCTION eureka_public.client_full_name(client eureka_public.client) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT client.name || ' ' || client.first_name || ' ' || client.last_name;
$$;
 K   DROP FUNCTION eureka_public.client_full_name(client eureka_public.client);
       eureka_public       eureka_administrador    false    7    217         A           1255    18136 8   collect_contract_debt(timestamp with time zone, integer)    FUNCTION     �  CREATE FUNCTION eureka_public.collect_contract_debt(date_of_debt timestamp with time zone, id_contract integer) RETURNS void
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        updated_contract_movement eureka_public.client_contract_movement;
        contract eureka_public.client_contract;
    BEGIN
        UPDATE
            eureka_public.client_contract_movement
        SET
            date = NOW(),
            movement = 'Pagado'
        WHERE
            eureka_public.client_contract_movement.date = $1
        AND
            eureka_public.client_contract_movement.id_contract = $2
        RETURNING
            *
        INTO
            updated_contract_movement;

        SELECT
            *
        FROM
            eureka_public.client_contract
        WHERE
            id = $2
        INTO
            contract;

        IF NOT EXISTS(
            SELECT
                1
            FROM
                eureka_public.client_contract_movement
            WHERE
                eureka_public.client_contract_movement.movement = 'Adeudo'
            AND
                eureka_public.client_contract_movement.id_contract = $2
        ) THEN
            IF EXISTS (
                SELECT
                    *
                FROM
                    eureka_public.client_contract_movement
                WHERE
                    eureka_public.client_contract_movement.date
                BETWEEN
                    contract.start_date
                AND
                    contract.end_date
                AND
                    eureka_public.client_contract_movement.movement = 'Por Pagar'
                AND
                    eureka_public.client_contract_movement.id_contract = $2
            ) THEN
                UPDATE eureka_public.client_contract SET status = 'Activo' WHERE id = $2;
            ELSEIF (
                TO_CHAR(NOW(), 'DD-MM-YYYY') < TO_CHAR(contract.end_date, 'DD-MM-YYYY')
            ) THEN
                UPDATE eureka_public.client_contract SET status = 'Activo' WHERE id = $2;
            ELSE
                UPDATE eureka_public.client_contract SET status = 'Finalizado' WHERE id = $2;
            END IF;
        END IF;

        RETURN;
    END;
$_$;
 o   DROP FUNCTION eureka_public.collect_contract_debt(date_of_debt timestamp with time zone, id_contract integer);
       eureka_public       eureka_administrador    false    7         /           1255    18139 Y   create_client(text, text, text, integer, integer, integer, text, eureka_public.contact[])    FUNCTION     �  CREATE FUNCTION eureka_public.create_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[]) RETURNS eureka_public.client
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        created_client eureka_public.client;
        client_contact eureka_public.contact;
    BEGIN
        IF EXISTS (
            SELECT
                1
            FROM
                eureka_public.client
            WHERE
                UNACCENT(eureka_public.client.name)
            LIKE
                UNACCENT($1)
            AND
                UNACCENT(eureka_public.client.first_name)
            LIKE
                UNACCENT($2)
            AND
                UNACCENT(eureka_public.client.last_name)
            LIKE
                UNACCENT($3)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || $1 || ' ' || $2 || ' ' || $3 || ' ya fue registrado.',
                HINT = 'Cliente ya Registrado';
        ELSE
            INSERT INTO eureka_public.client(
                name,
                first_name,
                last_name,
                id_town,
                id_township,
                id_street,
                exterior_number
            ) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING * INTO created_client;
            
            IF ARRAY_LENGTH($8, 1) > 0 THEN
                FOREACH client_contact IN ARRAY $8 LOOP
                    INSERT INTO eureka_public.client_contact(
                        type_contact,
                        contact,
                        id_client
                    ) VALUES(
                        client_contact.type_contact,
                        client_contact.contact,
                        created_client.id
                    );
                END LOOP;
            END IF;
        END IF;

        RETURN created_client;
    END;
$_$;
 �   DROP FUNCTION eureka_public.create_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[]);
       eureka_public       eureka_administrador    false    7    782    217         C           1255    18138 h   create_client_contract(text, integer, integer, integer, text, integer, eureka_public.contact[], integer)    FUNCTION     �  CREATE FUNCTION eureka_public.create_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id_client integer) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        months_quantity INTEGER;
        created_client_contract eureka_public.client_contract;
        business_contact eureka_public.contact;
        counter INTEGER := 0;
    BEGIN
        IF EXISTS(
            SELECT
                1
            FROM
                eureka_public.client_contract
            WHERE
                UNACCENT(eureka_public.client_contract.business)
            LIKE
                UNACCENT($1)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El contrato para el Negocio ' || $1 || ' ya fue registrado.',
                HINT = 'Contrato ya Registrado';
        ELSE
            SELECT number_months FROM eureka_public.client_contract_type WHERE id = $6 INTO months_quantity;

            INSERT INTO eureka_public.client_contract(
                business,
                id_town,
                id_township,
                id_street,
                exterior_number,
                id_type_contract,
                end_date,
                status,
                id_client
            ) VALUES(
                $1,
                $2,
                $3,
                $4,
                $5,
                $6,
                NOW() + (months_quantity || ' MONTHS')::INTERVAL,
                'Activo',
                $8
            ) RETURNING * INTO created_client_contract;

            IF ARRAY_LENGTH($7, 1) > 0 THEN
                FOREACH business_contact IN ARRAY $7 LOOP
                    INSERT INTO eureka_public.business_contact(
                        type_contact,
                        contact,
                        id_contract
                    ) VALUES(
                        business_contact.type_contact,
                        business_contact.contact,
                        created_client_contract.id
                    );
                END LOOP;
            END IF;

            FOR counter IN 1..months_quantity LOOP
                IF counter = 1 THEN
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        created_client_contract.start_date,
                        'Pagado',
                        created_client_contract.id
                    );
                ELSE
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        created_client_contract.start_date + (counter - 1 || ' MONTHS')::INTERVAL,
                        'Por Pagar',
                        created_client_contract.id
                    );
                END IF;
            END LOOP;
        END IF;

        RETURN created_client_contract;
    END;
$_$;
 �   DROP FUNCTION eureka_public.create_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id_client integer);
       eureka_public       eureka_administrador    false    782    222    7         B           1255    18137 K   create_client_contract_type(text, integer, numeric, text, numeric, numeric)    FUNCTION       CREATE FUNCTION eureka_public.create_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric) RETURNS eureka_public.client_contract_type
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_client_contract_type eureka_public.client_contract_type;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.client_contract_type WHERE eureka_public.client_contract_type.type_name LIKE $1) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato ' || $1 || ' ya fue registrado.',
                HINT = 'Tipo de Contrato ya Registrado';
        ELSE
            INSERT INTO eureka_public.client_contract_type(
                type_name,
                number_months,
                month_price,
                tax_type,
                tax_percentage,
                discount_percentage
            ) VALUES(
                $1,
                $2,
                $3,
                $4,
                ROUND($5 / 100::NUMERIC, 2),
                ROUND($6 / 100::NUMERIC, 2)
            ) RETURNING
                *
            INTO
                created_client_contract_type;
        END IF;

        RETURN created_client_contract_type;
    END;
$_$;
 �   DROP FUNCTION eureka_public.create_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric);
       eureka_public       eureka_administrador    false    220    7         7           1255    18140 m   create_employee(text, text, text, integer, integer, integer, text, eureka_public.contact[], text, text, text)    FUNCTION     �  CREATE FUNCTION eureka_public.create_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, password text, role text) RETURNS eureka_public.employee
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        created_employee eureka_public.employee;
        employee_contact eureka_public.contact;
    BEGIN
        IF EXISTS (
            SELECT
                1
            FROM
                eureka_public.employee
            WHERE
                UNACCENT(eureka_public.employee.name)
            LIKE
                UNACCENT($1)
            AND
                UNACCENT(eureka_public.employee.first_name)
            LIKE
                UNACCENT($2)
            AND
                UNACCENT(eureka_public.employee.last_name)
            LIKE
                UNACCENT($3)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El empleado ' || $1 || ' ' || $2 || ' ' || $3 || ' ya fue registrado.',
                HINT = 'Empleado ya Registrado';
        ELSE
            IF EXISTS (
                SELECT
                    1
                FROM
                    eureka_private.user
                WHERE
                    UNACCENT(eureka_private.user.username)
                ILIKE
                    UNACCENT($9)
            ) THEN
                RAISE EXCEPTION USING 
                    MESSAGE = 'El nombre de usuario ' || $9 || ' ya fue registrado por otro empleado.',
                    HINT = 'Nombre de Usuario ya Registrado';
            ELSE
                INSERT INTO eureka_public.employee(
                    name,
                    first_name,
                    last_name,
                    id_town,
                    id_township,
                    id_street,
                    exterior_number
                ) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING * INTO created_employee;

                IF ARRAY_LENGTH($8, 1) > 0 THEN
                    FOREACH employee_contact IN ARRAY $8 LOOP
                        INSERT INTO eureka_public.employee_contact(
                            type_contact,
                            contact,
                            id_employee
                        ) VALUES(
                            employee_contact.type_contact,
                            employee_contact.contact,
                            created_employee.id
                        );
                    END LOOP;
                END IF;

                INSERT INTO eureka_private.user(
                    username,
                    password,
                    role,
                    id_employee
                ) VALUES(
                    $9,
                    CRYPT($10, GEN_SALT('BF', 8)),
                    $11,
                    created_employee.id
                );
            END IF;
        END IF;

        RETURN created_employee;
    END;
$_$;
 �   DROP FUNCTION eureka_public.create_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, password text, role text);
       eureka_public       eureka_administrador    false    7    208    782         3           1255    18188 2   create_role(text, eureka_public.role_privileges[])    FUNCTION       CREATE FUNCTION eureka_public.create_role(role_name text, role_privileges eureka_public.role_privileges[]) RETURNS text
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        privileges eureka_public.role_privileges;
    BEGIN
        IF (SELECT 1 FROM pg_user WHERE usename ILIKE ('%' || 'eureka_' || LOWER($1) || '%')) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'Ese rol ya fue registrado.',
                HINT = 'Rol ya Registrado';
        ELSE
            EXECUTE 'CREATE ROLE ' || 'eureka_' || LOWER($1) || ' WITH LOGIN ENCRYPTED PASSWORD ' || 'eureka_' || LOWER($1) || ';';
            
            EXECUTE
                'GRANT ' || 'eureka_' || LOWER($1) || ' TO eureka_administrador;' ||
                'GRANT CONNECT ON DATABASE eureka TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE ON SCHEMA eureka_public TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE ON SCHEMA eureka_private TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA eureka_public TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA eureka_private TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee_user TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_private.employee_user_password TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.authenticate TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.current_employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.employee_full_name TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.employee_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.township TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_township TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_township TO ' || 'eureka_' || LOWER($1) || ';' || 
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.client_contract_movement TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.all_client_contracts TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client_contract_type TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_full_name TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.custom_to_char_client_contract_movement_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_formated_start_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_formated_end_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.update_contracts_status TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.all_contracts_to_pay TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.charge_month TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.pay_and_renovate_client_contract TO ' || 'eureka_' || LOWER($1) || ';';
            FOREACH privileges IN ARRAY $2 LOOP
                IF privileges.module = 'Clients' THEN
                    IF privileges.add_modify THEN
                        EXECUTE
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';

                    END IF;

                    IF privileges.delete THEN
                        EXECUTE
                            'GRANT DELETE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;
                ELSEIF privileges.module = 'Employees' THEN
                    IF privileges.add_modify THEN
                        EXECUTE
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;

                    IF privileges.delete THEN
                        EXECUTE
                            'GRANT DELETE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;
                END IF;
            END LOOP;
        END IF;

        RETURN 'eureka_' || $1;
    END;
$_$;
 j   DROP FUNCTION eureka_public.create_role(role_name text, role_privileges eureka_public.role_privileges[]);
       eureka_public       eureka_administrador    false    785    7         �            1259    17867    street    TABLE     {   CREATE TABLE eureka_public.street (
    id integer NOT NULL,
    street text NOT NULL,
    id_township integer NOT NULL
);
 !   DROP TABLE eureka_public.street;
       eureka_public         eureka_administrador    false    7         )           1255    18142    create_street(text, integer)    FUNCTION     �  CREATE FUNCTION eureka_public.create_street(street text, id_township integer) RETURNS eureka_public.street
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_street eureka_public.street;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.street WHERE UNACCENT(eureka_public.street.street) LIKE UNACCENT($1) AND eureka_public.street.id_township = $2) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'La Calle ' || $1 || ' ya fue registrada.',
                HINT = 'Calle ya Registrada';
        ELSE
            INSERT INTO eureka_public.street(street, id_township) VALUES($1, $2) RETURNING * INTO created_street;
        END IF;

        RETURN created_street;
    END;
$_$;
 M   DROP FUNCTION eureka_public.create_street(street text, id_township integer);
       eureka_public       eureka_administrador    false    206    7         �            1259    17835    town    TABLE     U   CREATE TABLE eureka_public.town (
    id integer NOT NULL,
    town text NOT NULL
);
    DROP TABLE eureka_public.town;
       eureka_public         eureka_administrador    false    7         0           1255    18143    create_town(text)    FUNCTION     g  CREATE FUNCTION eureka_public.create_town(town text) RETURNS eureka_public.town
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_town eureka_public.town;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.town WHERE UNACCENT(eureka_public.town.town) LIKE UNACCENT($1)) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'La ciudad ' || $1 || ' ya fue registrada.',
                HINT = 'Ciudad ya Registrada';
        ELSE
            INSERT INTO eureka_public.town(town) VALUES($1) RETURNING * INTO created_town;
        END IF;

        RETURN created_town;
    END;
$_$;
 4   DROP FUNCTION eureka_public.create_town(town text);
       eureka_public       eureka_administrador    false    7    202         �            1259    17848    township    TABLE     �   CREATE TABLE eureka_public.township (
    id integer NOT NULL,
    type_township text NOT NULL,
    township text NOT NULL,
    postal_code text NOT NULL,
    id_town integer NOT NULL
);
 #   DROP TABLE eureka_public.township;
       eureka_public         eureka_administrador    false    7         @           1255    18144 *   create_township(text, text, text, integer)    FUNCTION     �  CREATE FUNCTION eureka_public.create_township(type_township text, township text, postal_code text, id_town integer) RETURNS eureka_public.township
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_township eureka_public.township;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.township WHERE UNACCENT(eureka_public.township.township) LIKE UNACCENT($2) AND eureka_public.township.id_town = $4) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Asentamiento ' || $2 || ' ya fue registrado.',
                HINT = 'Asentamiento ya Registrado';
        ELSE
            INSERT INTO eureka_public.township(
                type_township,
                township,
                postal_code,
                id_town
            ) VALUES($1, $2, $3, $4) RETURNING
                *
            INTO
                created_township;
        END IF;

        RETURN created_township;
    END;
$_$;
 s   DROP FUNCTION eureka_public.create_township(type_township text, township text, postal_code text, id_town integer);
       eureka_public       eureka_administrador    false    204    7         ?           1255    17978    current_employee()    FUNCTION     l  CREATE FUNCTION eureka_public.current_employee() RETURNS eureka_public.current_employee
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        employee eureka_public.employee;
        employee_user eureka_public.employee_user;
        privileges_module eureka_public.privileges_module;
        privileges_employee eureka_public.privileges_module[];
    BEGIN
        SELECT
            *
        FROM
            eureka_public.employee
        WHERE
            id = CURRENT_SETTING('jwt.claims.id_employee')::INTEGER
        INTO
            employee;

        SELECT
            *
        FROM
            eureka_public.employee_user
        WHERE
            id_employee = CURRENT_SETTING('jwt.claims.id_employee')::INTEGER
        INTO
            employee_user;
        
        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || CURRENT_SETTING('jwt.claims.role')::TEXT || '%')
            GROUP BY
                table_name
        LOOP
            privileges_employee := ARRAY_APPEND(privileges_employee, privileges_module);
        END LOOP;

        RETURN (employee, employee_user, privileges_employee)::eureka_public.current_employee;
    END;
$$;
 0   DROP FUNCTION eureka_public.current_employee();
       eureka_public       eureka_administrador    false    7    749                    1255    18079 A   custom_to_char_client_contract_end_date(timestamp with time zone)    FUNCTION     �   CREATE FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
    SELECT TO_CHAR($1, 'DD-MM-YYYY');
$_$;
 _   DROP FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone);
       eureka_public       eureka_administrador    false    7         �	           0    0 J   FUNCTION custom_to_char_client_contract_end_date(timestamp with time zone)    COMMENT     p   COMMENT ON FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone) IS '@omit';
            eureka_public       eureka_administrador    false    282                    1255    18106 F   custom_to_char_client_contract_movement_date(timestamp with time zone)    FUNCTION     �   CREATE FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
    SELECT TO_CHAR($1, 'MM-YYYY');
$_$;
 d   DROP FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone);
       eureka_public       eureka_administrador    false    7         �	           0    0 O   FUNCTION custom_to_char_client_contract_movement_date(timestamp with time zone)    COMMENT     u   COMMENT ON FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone) IS '@omit';
            eureka_public       eureka_administrador    false    284         8           1255    18146    delete_client(integer)    FUNCTION     "  CREATE FUNCTION eureka_public.delete_client(id integer) RETURNS eureka_public.client
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        selected_id_contract INTEGER;
        client eureka_public.client;
    BEGIN
        SELECT
            eureka_public.client_contract.id
        FROM
            eureka_public.client_contract
        WHERE
            id_client = $1
        INTO
            selected_id_contract;

        SELECT * FROM eureka_public.client WHERE eureka_public.client.id = $1 INTO client;

        IF EXISTS (SELECT * FROM eureka_public.client_contract WHERE eureka_public.client_contract.id_client = client.id AND status LIKE 'Activo') THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || client.name || ' ' || client.first_name || ' ' || client.last_name || ' no puede ser eliminado pues cuenta con contratos que aun no han finalizado.',
                HINT = 'Contrato aun Activo';
        ELSEIF EXISTS (SELECT * FROM eureka_public.client_contract_movement WHERE eureka_public.client_contract_movement.movement LIKE 'Adeudo' AND eureka_public.client_contract_movement.id_contract = selected_id_contract) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || client.name || ' ' || client.first_name || ' ' || client.last_name || ' no puede ser eliminado pues tiene adeudos pendientes.',
                HINT = 'Adeudos Pendientes';
        ELSE
            DELETE FROM eureka_public.client WHERE eureka_public.client.id = $1;
        END IF;

        RETURN client;
    END;
$_$;
 7   DROP FUNCTION eureka_public.delete_client(id integer);
       eureka_public       eureka_administrador    false    217    7         #           1255    18145    delete_client_contract(integer)    FUNCTION       CREATE FUNCTION eureka_public.delete_client_contract(id integer) RETURNS eureka_public.client_contract
    LANGUAGE sql STRICT
    AS $_$
    DELETE FROM
        eureka_public.client_contract
    WHERE
        eureka_public.client_contract.id = $1
    RETURNING *;
$_$;
 @   DROP FUNCTION eureka_public.delete_client_contract(id integer);
       eureka_public       eureka_administrador    false    7    222         5           1255    19080 $   delete_client_contract_type(integer)    FUNCTION     �  CREATE FUNCTION eureka_public.delete_client_contract_type(id integer) RETURNS eureka_public.client_contract_type
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        deleted_client_contract_type eureka_public.client_contract_type;
    BEGIN
        IF (SELECT 1 FROM eureka_public.client_contract WHERE eureka_public.client_contract.id_type_contract = $1) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'Existe un contrato que tiene asignado este tipo de contrato, primero, debes de eliminar estos contratos.',
                HINT = 'No se puede eliminar este tipo de contrato';
        ELSE
            DELETE FROM
                eureka_public.client_contract_type
            WHERE
                eureka_public.client_contract_type.id = $1
            RETURNING
                *
            INTO
                deleted_client_contract_type;
        END IF;

        RETURN deleted_client_contract_type;
    END;
$_$;
 E   DROP FUNCTION eureka_public.delete_client_contract_type(id integer);
       eureka_public       eureka_administrador    false    220    7         $           1255    18147    delete_employee(integer)    FUNCTION     �   CREATE FUNCTION eureka_public.delete_employee(id integer) RETURNS eureka_public.employee
    LANGUAGE sql STRICT
    AS $_$
    DELETE FROM
        eureka_public.employee
    WHERE
        eureka_public.employee.id = $1
    RETURNING *;
$_$;
 9   DROP FUNCTION eureka_public.delete_employee(id integer);
       eureka_public       eureka_administrador    false    208    7         '           1255    18148    delete_role(text)    FUNCTION     �  CREATE FUNCTION eureka_public.delete_role(role_name text) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        formated_role_name TEXT;
    BEGIN
        IF EXISTS(SELECT * FROM eureka_public.employee_user WHERE role LIKE $1) THEN
            formated_role_name = INITCAP(REPLACE($1, 'eureka_', ''));

            RAISE EXCEPTION USING 
                MESSAGE = 'El rol ' || formated_role_name || ' no puede ser eliminado porque fue asignado a un empleado, primero, elimine a todos los empleados que cuenten con este rol asignado.',
                HINT = 'No se puede eliminar el Rol';
        ELSE
            EXECUTE
                'REVOKE ' || $1 || ' FROM eureka_administrador;' ||
                'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL SEQUENCES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL SEQUENCES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL FUNCTIONS IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL FUNCTIONS IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL TABLES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA eureka_public  FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL TABLES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE USAGE ON SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE USAGE ON SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE CONNECT ON DATABASE eureka FROM ' || $1 || ';' ||
                'DROP ROLE ' || $1 || ';';
        END IF;

        RETURN $1;
    END;
$_$;
 9   DROP FUNCTION eureka_public.delete_role(role_name text);
       eureka_public       eureka_administrador    false    7         1           1255    18126    employee_by_id(integer)    FUNCTION     -  CREATE FUNCTION eureka_public.employee_by_id(id integer) RETURNS eureka_public.selected_employee
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
    DECLARE
        employee eureka_public.employee;
        employee_user eureka_public.employee_user;
        selected_employee eureka_public.selected_employee;
    BEGIN
        SELECT
            *
        FROM
            eureka_public.employee
        WHERE
            eureka_public.employee.id = $1
        INTO
            employee;

        SELECT
            *
        FROM
            eureka_public.employee_user
        WHERE
            eureka_public.employee_user.id_employee = $1
        INTO
            employee_user;

        selected_employee = (employee, employee_user)::eureka_public.selected_employee;

        RETURN selected_employee;
    END;
$_$;
 8   DROP FUNCTION eureka_public.employee_by_id(id integer);
       eureka_public       eureka_administrador    false    7    779         6           1255    17960 -   employee_full_address(eureka_public.employee)    FUNCTION     X  CREATE FUNCTION eureka_public.employee_full_address(employee_table eureka_public.employee) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.employee.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.employee
        ON
            eureka_public.town.id = eureka_public.employee.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.employee.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.employee.id_street
        WHERE
            eureka_public.employee.id = employee_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;
 Z   DROP FUNCTION eureka_public.employee_full_address(employee_table eureka_public.employee);
       eureka_public       eureka_administrador    false    208    7         %           1255    17959 *   employee_full_name(eureka_public.employee)    FUNCTION     �   CREATE FUNCTION eureka_public.employee_full_name(employee eureka_public.employee) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT employee.name || ' ' || employee.first_name || ' ' || employee.last_name;
$$;
 Q   DROP FUNCTION eureka_public.employee_full_name(employee eureka_public.employee);
       eureka_public       eureka_administrador    false    208    7         >           1255    18151 b   modify_client(text, text, text, integer, integer, integer, text, eureka_public.contact[], integer)    FUNCTION     2  CREATE FUNCTION eureka_public.modify_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], id integer) RETURNS eureka_public.client
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        modified_client eureka_public.client;
        client_contact eureka_public.contact;
    BEGIN
        UPDATE
            eureka_public.client
        SET
            name = $1,
            first_name = $2,
            last_name = $3,
            id_town = $4,
            id_township = $5,
            id_street = $6,
            exterior_number = $7
        WHERE
            client.id = $9
        RETURNING
            *
        INTO
            modified_client;

        DELETE FROM eureka_public.client_contact WHERE id_client = $9;
        
        IF ARRAY_LENGTH($8, 1) > 0 THEN
            FOREACH client_contact IN ARRAY $8 LOOP
                INSERT INTO eureka_public.client_contact(
                    type_contact,
                    contact,
                    id_client
                ) VALUES(
                    client_contact.type_contact,
                    client_contact.contact,
                    $9
                );
            END LOOP;
        END IF;

        RETURN modified_client;
    END;
$_$;
 �   DROP FUNCTION eureka_public.modify_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], id integer);
       eureka_public       eureka_administrador    false    7    217    782         =           1255    18150 h   modify_client_contract(text, integer, integer, integer, text, integer, eureka_public.contact[], integer)    FUNCTION       CREATE FUNCTION eureka_public.modify_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id integer) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        selected_client_contract eureka_public.client_contract;
        months_quantity INTEGER;
        modified_client_contract eureka_public.client_contract;
        business_contact eureka_public.contact;
    BEGIN
        SELECT * FROM eureka_public.client_contract WHERE eureka_public.client_contract.id = $8 INTO selected_client_contract;
        SELECT number_months FROM eureka_public.client_contract_type WHERE eureka_public.client_contract_type.id = $6 INTO months_quantity;

        IF $6 <> selected_client_contract.id_type_contract AND selected_client_contract.status = 'Por Pagar' THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato no puede ser modificado, pues este contrato esta por realizar su pago correspondiente.',
                HINT = 'Pago Pendiente';
        ELSEIF $6 <> selected_client_contract.id_type_contract AND selected_client_contract.status = 'Adeudo' THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato no puede ser modificado, pues este contrato tiene adeudos pendientes.',
                HINT = 'Adeudos Pendiente';
        ELSE
            UPDATE
                eureka_public.client_contract
            SET
                business = $1,
                id_town = $2,
                id_township = $3,
                id_street = $4,
                exterior_number = $5,
                id_type_contract = $6,
                end_date = start_date + (months_quantity || ' MONTHS')::INTERVAL
            WHERE
                eureka_public.client_contract.id = $8
            RETURNING * INTO modified_client_contract;

            DELETE FROM eureka_public.business_contact WHERE eureka_public.business_contact.id_contract = $8;

            IF ARRAY_LENGTH($7, 1) > 0 THEN
                FOREACH business_contact IN ARRAY $7 LOOP
                    INSERT INTO eureka_public.business_contact(
                        type_contact,
                        contact,
                        id_contract
                    ) VALUES(
                        business_contact.type_contact,
                        business_contact.contact,
                        modified_client_contract.id
                    );
                END LOOP;
            END IF;

            DELETE FROM eureka_public.client_contract_movement WHERE eureka_public.client_contract_movement.date BETWEEN selected_client_contract.start_date AND selected_client_contract.end_date AND eureka_public.client_contract_movement.id_contract = $8;

            FOR counter IN 1..months_quantity LOOP
                IF counter = 1 THEN
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        modified_client_contract.start_date,
                        'Pagado',
                        modified_client_contract.id
                    );
                ELSE
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        modified_client_contract.start_date + ('3 DAYS ' || counter - 1 || ' MONTHS')::INTERVAL,
                        'Por Pagar',
                        modified_client_contract.id
                    );
                END IF;
            END LOOP;
        END IF;

        RETURN modified_client_contract;
    END;
$_$;
 �   DROP FUNCTION eureka_public.modify_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id integer);
       eureka_public       eureka_administrador    false    7    782    222         <           1255    18149 T   modify_client_contract_type(text, integer, numeric, text, numeric, numeric, integer)    FUNCTION     `  CREATE FUNCTION eureka_public.modify_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric, id integer) RETURNS eureka_public.client_contract_type
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.client_contract_type
    SET
        type_name = $1,
        number_months = $2,
        month_price = $3, 
        tax_type = $4,
        tax_percentage = ROUND($5 / 100::NUMERIC, 2),
        discount_percentage = ROUND($6 / 100::NUMERIC, 2)
    WHERE
        id = $7
    RETURNING
        *;
$_$;
 �   DROP FUNCTION eureka_public.modify_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric, id integer);
       eureka_public       eureka_administrador    false    220    7         9           1255    18152 v   modify_employee(text, text, text, integer, integer, integer, text, eureka_public.contact[], text, text, integer, text)    FUNCTION     �  CREATE FUNCTION eureka_public.modify_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, role text, id integer, password text DEFAULT 'REEMPLAZAME'::text) RETURNS eureka_public.selected_employee
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        modified_employee eureka_public.employee;
        employee_contact eureka_public.contact;
        employee_user eureka_public.employee_user;
        selected_employee eureka_public.selected_employee;
    BEGIN
        UPDATE
            eureka_public.employee
        SET
            name = $1,
            first_name = $2,
            last_name = $3,
            id_town = $4,
            id_township = $5,
            id_street = $6,
            exterior_number = $7
        WHERE
            eureka_public.employee.id = $11
        RETURNING * INTO modified_employee;

        DELETE FROM eureka_public.employee_contact WHERE eureka_public.employee_contact.id_employee = $11;

        IF ARRAY_LENGTH($8, 1) > 0 THEN
            FOREACH employee_contact IN ARRAY $8 LOOP
                INSERT INTO eureka_public.employee_contact(
                    type_contact,
                    contact,
                    id_employee
                ) VALUES(
                    employee_contact.type_contact,
                    employee_contact.contact,
                    $11
                );
            END LOOP;
        END IF;

        UPDATE
            eureka_public.employee_user
        SET
            username = $9,
            role = $10
        WHERE
            eureka_public.employee_user.id_employee = $11
        RETURNING 
            *
        INTO
            employee_user;

        IF $12 <> 'REEMPLAZAME' THEN
            UPDATE 
                eureka_private.employee_user_password
            SET
                password_hash = CRYPT($12, GEN_SALT('BF', 8))
            WHERE
                eureka_private.employee_user_password.id_employee_user = $11;
        END IF;

        selected_employee = (modified_employee, employee_user)::eureka_public.selected_employee;

        RETURN selected_employee;
    END;
$_$;
 �   DROP FUNCTION eureka_public.modify_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, role text, id integer, password text);
       eureka_public       eureka_administrador    false    7    782    779         -           1255    19086 8   modify_role(text, text, eureka_public.role_privileges[])    FUNCTION     &  CREATE FUNCTION eureka_public.modify_role(role_name text, prev_role_name text, role_privileges eureka_public.role_privileges[]) RETURNS eureka_public.selected_role
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        privileges eureka_public.role_privileges;
        privileges_module eureka_public.privileges_module;
        privileges_role eureka_public.privileges_module[];
        selected_role eureka_public.selected_role;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE pg_roles.rolname LIKE 'eureka_' || LOWER($1)) THEN
            EXECUTE 'ALTER ROLE ' || 'eureka_' || LOWER($2) || ' RENAME TO ' || 'eureka_' || LOWER($1) || ';';
        END IF;

        FOREACH privileges IN ARRAY $3 LOOP
            IF privileges.module = 'Clients' THEN
                IF privileges.add_modify THEN
                    EXECUTE
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client_contact FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client_contract FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.business_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;

                IF privileges.delete THEN
                    EXECUTE
                        'GRANT DELETE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE DELETE ON TABLE eureka_public.client FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.client_contact FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.client_contract FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.business_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;
            ELSEIF privileges.module = 'Employees' THEN
                IF privileges.add_modify THEN
                    EXECUTE
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.employee FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.employee_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;

                IF privileges.delete THEN
                    EXECUTE
                        'GRANT DELETE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE DELETE ON TABLE eureka_public.employee FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.employee_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;
            END IF;
        END LOOP;

        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || 'eureka_' || LOWER($1) || '%')
            GROUP BY
                table_name
        LOOP
            privileges_role := ARRAY_APPEND(privileges_role, privileges_module);
        END LOOP;

        selected_role := ($1, privileges_role);

        RETURN selected_role;
    END;
$_$;
    DROP FUNCTION eureka_public.modify_role(role_name text, prev_role_name text, role_privileges eureka_public.role_privileges[]);
       eureka_public       eureka_administrador    false    788    785    7         D           1255    18154 %   modify_street(text, integer, integer)    FUNCTION     0  CREATE FUNCTION eureka_public.modify_street(street text, id_township integer, id integer) RETURNS eureka_public.street
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.street
    SET
        street = $1,
        id_township = $2
    WHERE
        id = $3
    RETURNING
        *;
$_$;
 Y   DROP FUNCTION eureka_public.modify_street(street text, id_township integer, id integer);
       eureka_public       eureka_administrador    false    206    7         &           1255    18155    modify_town(integer, text)    FUNCTION     �   CREATE FUNCTION eureka_public.modify_town(id integer, town text) RETURNS eureka_public.town
    LANGUAGE sql STRICT
    AS $_$
    UPDATE eureka_public.town SET town = $2 WHERE id = $1 RETURNING *;
$_$;
 @   DROP FUNCTION eureka_public.modify_town(id integer, town text);
       eureka_public       eureka_administrador    false    7    202         .           1255    18156 3   modify_township(text, text, text, integer, integer)    FUNCTION     �  CREATE FUNCTION eureka_public.modify_township(type_township text, township text, postal_code text, id_town integer, id integer) RETURNS eureka_public.township
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.township
    SET
        type_township = $1,
        township = $2,
        postal_code = $3,
        id_town = $4
    WHERE
        id = $5
    RETURNING
        *;
$_$;
    DROP FUNCTION eureka_public.modify_township(type_township text, township text, postal_code text, id_town integer, id integer);
       eureka_public       eureka_administrador    false    204    7         I           1255    18157 /   pay_and_renovate_client_contract(integer, text)    FUNCTION     g  CREATE FUNCTION eureka_public.pay_and_renovate_client_contract(id_contract integer, type_contract text) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        renovated_client_contract eureka_public.client_contract;
        translated_type_contract TEXT;
    BEGIN
        IF $2 = '1 MES' THEN
            translated_type_contract = REPLACE($2, 'MES', 'MONTH');
        ELSE
            translated_type_contract = REPLACE($2, 'MESES', 'MONTHS');
        END IF;

        UPDATE
            eureka_public.client_contract
        SET
            type_contract = $2,
            start_date = NOW(),
            end_date = NOW() + translated_type_contract::INTERVAL,
            status = 'Activo'
        WHERE
            id = $1
        RETURNING * INTO 
            renovated_client_contract;

        IF $2 = '1 MES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );
        ELSEIF $2 = '2 MESES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 1 MONTH'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );
        ELSEIF $2 = '3 MESES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 1 MONTH'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 2 MONTHS'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );
        END IF;

        RETURN renovated_client_contract;
    END;
$_$;
 g   DROP FUNCTION eureka_public.pay_and_renovate_client_contract(id_contract integer, type_contract text);
       eureka_public       eureka_administrador    false    7    222         4           1255    18190    role_by_name(text)    FUNCTION     s  CREATE FUNCTION eureka_public.role_by_name(role_name text) RETURNS eureka_public.selected_role
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
    DECLARE
        privileges_module eureka_public.privileges_module;
        privileges_role eureka_public.privileges_module[];
        selected_role eureka_public.selected_role;
    BEGIN
        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || $1 || '%')
            GROUP BY
                table_name
        LOOP
            privileges_role := ARRAY_APPEND(privileges_role, privileges_module);
        END LOOP;

        selected_role := ($1, privileges_role);

        RETURN selected_role;
    END;
$_$;
 :   DROP FUNCTION eureka_public.role_by_name(role_name text);
       eureka_public       eureka_administrador    false    788    7         G           1255    18109    update_contracts_status()    FUNCTION     q  CREATE FUNCTION eureka_public.update_contracts_status() RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
        contract eureka_public.client_contract;
        contract_movement eureka_public.client_contract_movement;
    BEGIN
        FOR contract IN
            SELECT * FROM eureka_public.client_contract WHERE TO_CHAR(end_date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY')
        LOOP
            IF NOT EXISTS(SELECT * FROM eureka_public.client_contract_movement WHERE date BETWEEN contract.start_date AND contract.end_date AND movement LIKE 'Adeudo') THEN
                UPDATE eureka_public.client_contract SET status = 'Finalizado' WHERE id = contract.id;
            END IF;
        END LOOP;

        FOR contract_movement IN
            SELECT * FROM eureka_public.client_contract_movement WHERE TO_CHAR(date, 'MM-YYYY') = TO_CHAR(NOW(), 'MM-YYYY')
        LOOP
            IF TO_CHAR(contract_movement.date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY') AND contract_movement.movement LIKE 'Por Pagar' THEN
                UPDATE eureka_public.client_contract SET status = 'Por Pagar' WHERE id = contract_movement.id_contract;
            ELSEIF TO_CHAR(contract_movement.date, 'DD-MM-YYYY') < TO_CHAR(NOW(), 'DD-MM-YYYY') AND contract_movement.movement LIKE 'Por Pagar' THEN
                UPDATE eureka_public.client_contract SET status = 'Adeudo' WHERE id = contract_movement.id_contract;
                UPDATE eureka_public.client_contract_movement SET movement = 'Adeudo' WHERE movement LIKE 'Por Pagar' AND id_contract = contract_movement.id_contract;
            END IF;
        END LOOP;

        RETURN;
    END;
$$;
 7   DROP FUNCTION eureka_public.update_contracts_status();
       eureka_public       eureka_administrador    false    7         +           1255    19088    notify_watchers_ddl()    FUNCTION     �  CREATE FUNCTION postgraphile_watch.notify_watchers_ddl() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'ddl',
      'payload',
      (select json_agg(json_build_object('schema', schema_name, 'command', command_tag)) from pg_event_trigger_ddl_commands() as x)
    )::text
  );
end;
$$;
 8   DROP FUNCTION postgraphile_watch.notify_watchers_ddl();
       postgraphile_watch       eureka_administrador    false    11         ,           1255    19089    notify_watchers_drop()    FUNCTION     _  CREATE FUNCTION postgraphile_watch.notify_watchers_drop() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'drop',
      'payload',
      (select json_agg(distinct x.schema_name) from pg_event_trigger_dropped_objects() as x)
    )::text
  );
end;
$$;
 9   DROP FUNCTION postgraphile_watch.notify_watchers_drop();
       postgraphile_watch       eureka_administrador    false    11         �            1259    17945    employee_user_password    TABLE        CREATE TABLE eureka_private.employee_user_password (
    password_hash text NOT NULL,
    id_employee_user integer NOT NULL
);
 2   DROP TABLE eureka_private.employee_user_password;
       eureka_private         eureka_administrador    false    12         �            1259    18081    business_contact    TABLE     �   CREATE TABLE eureka_public.business_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_contract integer NOT NULL
);
 +   DROP TABLE eureka_public.business_contact;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE business_contact    COMMENT     @   COMMENT ON TABLE eureka_public.business_contact IS '@omit all';
            eureka_public       eureka_administrador    false    223         �            1259    18009    client_contact    TABLE     �   CREATE TABLE eureka_public.client_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_client integer NOT NULL
);
 )   DROP TABLE eureka_public.client_contact;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE client_contact    COMMENT     >   COMMENT ON TABLE eureka_public.client_contact IS '@omit all';
            eureka_public       eureka_administrador    false    218         �            1259    18035    client_contract_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.client_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE eureka_public.client_contract_id_seq;
       eureka_public       eureka_administrador    false    222    7         �	           0    0    client_contract_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE eureka_public.client_contract_id_seq OWNED BY eureka_public.client_contract.id;
            eureka_public       eureka_administrador    false    221         �            1259    18021    client_contract_type_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.client_contract_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE eureka_public.client_contract_type_id_seq;
       eureka_public       eureka_administrador    false    7    220         �	           0    0    client_contract_type_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE eureka_public.client_contract_type_id_seq OWNED BY eureka_public.client_contract_type.id;
            eureka_public       eureka_administrador    false    219         �            1259    17979    client_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE eureka_public.client_id_seq;
       eureka_public       eureka_administrador    false    217    7         �	           0    0    client_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE eureka_public.client_id_seq OWNED BY eureka_public.client.id;
            eureka_public       eureka_administrador    false    216         �            1259    17912    employee_contact    TABLE     �   CREATE TABLE eureka_public.employee_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_employee integer NOT NULL
);
 +   DROP TABLE eureka_public.employee_contact;
       eureka_public         eureka_administrador    false    7         �	           0    0    TABLE employee_contact    COMMENT     @   COMMENT ON TABLE eureka_public.employee_contact IS '@omit all';
            eureka_public       eureka_administrador    false    209         �            1259    17882    employee_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE eureka_public.employee_id_seq;
       eureka_public       eureka_administrador    false    208    7         �	           0    0    employee_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE eureka_public.employee_id_seq OWNED BY eureka_public.employee.id;
            eureka_public       eureka_administrador    false    207         �            1259    17924    employee_user_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.employee_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE eureka_public.employee_user_id_seq;
       eureka_public       eureka_administrador    false    7    211         �	           0    0    employee_user_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE eureka_public.employee_user_id_seq OWNED BY eureka_public.employee_user.id;
            eureka_public       eureka_administrador    false    210         �            1259    17865    street_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE eureka_public.street_id_seq;
       eureka_public       eureka_administrador    false    7    206         �	           0    0    street_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE eureka_public.street_id_seq OWNED BY eureka_public.street.id;
            eureka_public       eureka_administrador    false    205         �            1259    17833    town_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.town_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE eureka_public.town_id_seq;
       eureka_public       eureka_administrador    false    202    7         �	           0    0    town_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE eureka_public.town_id_seq OWNED BY eureka_public.town.id;
            eureka_public       eureka_administrador    false    201         �            1259    17846    township_id_seq    SEQUENCE     �   CREATE SEQUENCE eureka_public.township_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE eureka_public.township_id_seq;
       eureka_public       eureka_administrador    false    7    204         �	           0    0    township_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE eureka_public.township_id_seq OWNED BY eureka_public.township.id;
            eureka_public       eureka_administrador    false    203         �           2604    17984 	   client id    DEFAULT     t   ALTER TABLE ONLY eureka_public.client ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_id_seq'::regclass);
 ?   ALTER TABLE eureka_public.client ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    216    217    217         �           2604    18040    client_contract id    DEFAULT     �   ALTER TABLE ONLY eureka_public.client_contract ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_contract_id_seq'::regclass);
 H   ALTER TABLE eureka_public.client_contract ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    221    222    222         �           2604    18026    client_contract_type id    DEFAULT     �   ALTER TABLE ONLY eureka_public.client_contract_type ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_contract_type_id_seq'::regclass);
 M   ALTER TABLE eureka_public.client_contract_type ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    220    219    220         �           2604    17887    employee id    DEFAULT     x   ALTER TABLE ONLY eureka_public.employee ALTER COLUMN id SET DEFAULT nextval('eureka_public.employee_id_seq'::regclass);
 A   ALTER TABLE eureka_public.employee ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    208    207    208         �           2604    17929    employee_user id    DEFAULT     �   ALTER TABLE ONLY eureka_public.employee_user ALTER COLUMN id SET DEFAULT nextval('eureka_public.employee_user_id_seq'::regclass);
 F   ALTER TABLE eureka_public.employee_user ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    210    211    211         �           2604    17870 	   street id    DEFAULT     t   ALTER TABLE ONLY eureka_public.street ALTER COLUMN id SET DEFAULT nextval('eureka_public.street_id_seq'::regclass);
 ?   ALTER TABLE eureka_public.street ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    205    206    206         �           2604    17838    town id    DEFAULT     p   ALTER TABLE ONLY eureka_public.town ALTER COLUMN id SET DEFAULT nextval('eureka_public.town_id_seq'::regclass);
 =   ALTER TABLE eureka_public.town ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    201    202    202         �           2604    17851    township id    DEFAULT     x   ALTER TABLE ONLY eureka_public.township ALTER COLUMN id SET DEFAULT nextval('eureka_public.township_id_seq'::regclass);
 A   ALTER TABLE eureka_public.township ALTER COLUMN id DROP DEFAULT;
       eureka_public       eureka_administrador    false    204    203    204         �	          0    17945    employee_user_password 
   TABLE DATA               Y   COPY eureka_private.employee_user_password (password_hash, id_employee_user) FROM stdin;
    eureka_private       eureka_administrador    false    212       2458.dat �	          0    18081    business_contact 
   TABLE DATA               U   COPY eureka_public.business_contact (type_contact, contact, id_contract) FROM stdin;
    eureka_public       eureka_administrador    false    223       2466.dat �	          0    17981    client 
   TABLE DATA               �   COPY eureka_public.client (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM stdin;
    eureka_public       eureka_administrador    false    217       2460.dat �	          0    18009    client_contact 
   TABLE DATA               Q   COPY eureka_public.client_contact (type_contact, contact, id_client) FROM stdin;
    eureka_public       eureka_administrador    false    218       2461.dat �	          0    18037    client_contract 
   TABLE DATA               �   COPY eureka_public.client_contract (id, business, id_town, id_township, id_street, exterior_number, id_type_contract, start_date, end_date, status, id_client) FROM stdin;
    eureka_public       eureka_administrador    false    222       2465.dat �	          0    18094    client_contract_movement 
   TABLE DATA               V   COPY eureka_public.client_contract_movement (date, movement, id_contract) FROM stdin;
    eureka_public       eureka_administrador    false    224       2467.dat �	          0    18023    client_contract_type 
   TABLE DATA               �   COPY eureka_public.client_contract_type (id, type_name, number_months, month_price, tax_type, tax_percentage, discount_percentage) FROM stdin;
    eureka_public       eureka_administrador    false    220       2463.dat �	          0    17884    employee 
   TABLE DATA               �   COPY eureka_public.employee (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM stdin;
    eureka_public       eureka_administrador    false    208       2454.dat �	          0    17912    employee_contact 
   TABLE DATA               U   COPY eureka_public.employee_contact (type_contact, contact, id_employee) FROM stdin;
    eureka_public       eureka_administrador    false    209       2455.dat �	          0    17926    employee_user 
   TABLE DATA               O   COPY eureka_public.employee_user (id, username, role, id_employee) FROM stdin;
    eureka_public       eureka_administrador    false    211       2457.dat �	          0    17867    street 
   TABLE DATA               @   COPY eureka_public.street (id, street, id_township) FROM stdin;
    eureka_public       eureka_administrador    false    206       2452.dat �	          0    17835    town 
   TABLE DATA               /   COPY eureka_public.town (id, town) FROM stdin;
    eureka_public       eureka_administrador    false    202       2448.dat �	          0    17848    township 
   TABLE DATA               \   COPY eureka_public.township (id, type_township, township, postal_code, id_town) FROM stdin;
    eureka_public       eureka_administrador    false    204       2450.dat �	           0    0    client_contract_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('eureka_public.client_contract_id_seq', 1, true);
            eureka_public       eureka_administrador    false    221         �	           0    0    client_contract_type_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('eureka_public.client_contract_type_id_seq', 2, true);
            eureka_public       eureka_administrador    false    219         �	           0    0    client_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('eureka_public.client_id_seq', 1, true);
            eureka_public       eureka_administrador    false    216         �	           0    0    employee_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('eureka_public.employee_id_seq', 2, true);
            eureka_public       eureka_administrador    false    207         �	           0    0    employee_user_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('eureka_public.employee_user_id_seq', 2, true);
            eureka_public       eureka_administrador    false    210         �	           0    0    street_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('eureka_public.street_id_seq', 3, true);
            eureka_public       eureka_administrador    false    205         �	           0    0    town_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('eureka_public.town_id_seq', 3, true);
            eureka_public       eureka_administrador    false    201         �	           0    0    township_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('eureka_public.township_id_seq', 3, true);
            eureka_public       eureka_administrador    false    203         �           2606    17952 B   employee_user_password employee_user_password_id_employee_user_key 
   CONSTRAINT     �   ALTER TABLE ONLY eureka_private.employee_user_password
    ADD CONSTRAINT employee_user_password_id_employee_user_key UNIQUE (id_employee_user);
 t   ALTER TABLE ONLY eureka_private.employee_user_password DROP CONSTRAINT employee_user_password_id_employee_user_key;
       eureka_private         eureka_administrador    false    212         �           2606    18048 ,   client_contract client_contract_business_key 
   CONSTRAINT     r   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_business_key UNIQUE (business);
 ]   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_business_key;
       eureka_public         eureka_administrador    false    222         �	           0    0 :   CONSTRAINT client_contract_business_key ON client_contract    COMMENT     `   COMMENT ON CONSTRAINT client_contract_business_key ON eureka_public.client_contract IS '@omit';
            eureka_public       eureka_administrador    false    2294         �           2606    18046 $   client_contract client_contract_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_pkey;
       eureka_public         eureka_administrador    false    222         �           2606    18031 .   client_contract_type client_contract_type_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY eureka_public.client_contract_type
    ADD CONSTRAINT client_contract_type_pkey PRIMARY KEY (id);
 _   ALTER TABLE ONLY eureka_public.client_contract_type DROP CONSTRAINT client_contract_type_pkey;
       eureka_public         eureka_administrador    false    220         �           2606    18033 7   client_contract_type client_contract_type_type_name_key 
   CONSTRAINT     ~   ALTER TABLE ONLY eureka_public.client_contract_type
    ADD CONSTRAINT client_contract_type_type_name_key UNIQUE (type_name);
 h   ALTER TABLE ONLY eureka_public.client_contract_type DROP CONSTRAINT client_contract_type_type_name_key;
       eureka_public         eureka_administrador    false    220         �	           0    0 E   CONSTRAINT client_contract_type_type_name_key ON client_contract_type    COMMENT     k   COMMENT ON CONSTRAINT client_contract_type_type_name_key ON eureka_public.client_contract_type IS '@omit';
            eureka_public       eureka_administrador    false    2292         �           2606    17990    client client_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY eureka_public.client DROP CONSTRAINT client_pkey;
       eureka_public         eureka_administrador    false    217         �           2606    17893    employee employee_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY eureka_public.employee DROP CONSTRAINT employee_pkey;
       eureka_public         eureka_administrador    false    208         �	           0    0 $   CONSTRAINT employee_pkey ON employee    COMMENT     J   COMMENT ON CONSTRAINT employee_pkey ON eureka_public.employee IS '@omit';
            eureka_public       eureka_administrador    false    2271         �           2606    17938 +   employee_user employee_user_id_employee_key 
   CONSTRAINT     t   ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_id_employee_key UNIQUE (id_employee);
 \   ALTER TABLE ONLY eureka_public.employee_user DROP CONSTRAINT employee_user_id_employee_key;
       eureka_public         eureka_administrador    false    211         �	           0    0 9   CONSTRAINT employee_user_id_employee_key ON employee_user    COMMENT     _   COMMENT ON CONSTRAINT employee_user_id_employee_key ON eureka_public.employee_user IS '@omit';
            eureka_public       eureka_administrador    false    2275         �           2606    17934     employee_user employee_user_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY eureka_public.employee_user DROP CONSTRAINT employee_user_pkey;
       eureka_public         eureka_administrador    false    211         �	           0    0 .   CONSTRAINT employee_user_pkey ON employee_user    COMMENT     T   COMMENT ON CONSTRAINT employee_user_pkey ON eureka_public.employee_user IS '@omit';
            eureka_public       eureka_administrador    false    2277         �           2606    17936 (   employee_user employee_user_username_key 
   CONSTRAINT     n   ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_username_key UNIQUE (username);
 Y   ALTER TABLE ONLY eureka_public.employee_user DROP CONSTRAINT employee_user_username_key;
       eureka_public         eureka_administrador    false    211         �	           0    0 6   CONSTRAINT employee_user_username_key ON employee_user    COMMENT     \   COMMENT ON CONSTRAINT employee_user_username_key ON eureka_public.employee_user IS '@omit';
            eureka_public       eureka_administrador    false    2279         �           2606    17875    street street_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY eureka_public.street
    ADD CONSTRAINT street_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY eureka_public.street DROP CONSTRAINT street_pkey;
       eureka_public         eureka_administrador    false    206         �           2606    17843    town town_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY eureka_public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY eureka_public.town DROP CONSTRAINT town_pkey;
       eureka_public         eureka_administrador    false    202         �           2606    17845    town town_town_key 
   CONSTRAINT     T   ALTER TABLE ONLY eureka_public.town
    ADD CONSTRAINT town_town_key UNIQUE (town);
 C   ALTER TABLE ONLY eureka_public.town DROP CONSTRAINT town_town_key;
       eureka_public         eureka_administrador    false    202         �	           0    0     CONSTRAINT town_town_key ON town    COMMENT     F   COMMENT ON CONSTRAINT town_town_key ON eureka_public.town IS '@omit';
            eureka_public       eureka_administrador    false    2258         �           2606    17856    township township_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY eureka_public.township DROP CONSTRAINT township_pkey;
       eureka_public         eureka_administrador    false    204         �           2606    17858 !   township township_postal_code_key 
   CONSTRAINT     j   ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_postal_code_key UNIQUE (postal_code);
 R   ALTER TABLE ONLY eureka_public.township DROP CONSTRAINT township_postal_code_key;
       eureka_public         eureka_administrador    false    204         �	           0    0 /   CONSTRAINT township_postal_code_key ON township    COMMENT     U   COMMENT ON CONSTRAINT township_postal_code_key ON eureka_public.township IS '@omit';
            eureka_public       eureka_administrador    false    2263         �           1259    17958 +   employee_user_password_id_employee_user_idx    INDEX     �   CREATE INDEX employee_user_password_id_employee_user_idx ON eureka_private.employee_user_password USING btree (id_employee_user);
 G   DROP INDEX eureka_private.employee_user_password_id_employee_user_idx;
       eureka_private         eureka_administrador    false    212         �           1259    18092     business_contact_id_contract_idx    INDEX     k   CREATE INDEX business_contact_id_contract_idx ON eureka_public.business_contact USING btree (id_contract);
 ;   DROP INDEX eureka_public.business_contact_id_contract_idx;
       eureka_public         eureka_administrador    false    223         �           1259    18020    client_contact_id_client_idx    INDEX     c   CREATE INDEX client_contact_id_client_idx ON eureka_public.client_contact USING btree (id_client);
 7   DROP INDEX eureka_public.client_contact_id_client_idx;
       eureka_public         eureka_administrador    false    218         �           1259    18080    client_contract_end_date_idx    INDEX     �   CREATE INDEX client_contract_end_date_idx ON eureka_public.client_contract USING btree (eureka_public.custom_to_char_client_contract_end_date(end_date));
 7   DROP INDEX eureka_public.client_contract_end_date_idx;
       eureka_public         eureka_administrador    false    282    222    222         �           1259    18078    client_contract_id_client_idx    INDEX     e   CREATE INDEX client_contract_id_client_idx ON eureka_public.client_contract USING btree (id_client);
 8   DROP INDEX eureka_public.client_contract_id_client_idx;
       eureka_public         eureka_administrador    false    222         �           1259    18076    client_contract_id_street_idx    INDEX     e   CREATE INDEX client_contract_id_street_idx ON eureka_public.client_contract USING btree (id_street);
 8   DROP INDEX eureka_public.client_contract_id_street_idx;
       eureka_public         eureka_administrador    false    222         �           1259    18074    client_contract_id_town_idx    INDEX     a   CREATE INDEX client_contract_id_town_idx ON eureka_public.client_contract USING btree (id_town);
 6   DROP INDEX eureka_public.client_contract_id_town_idx;
       eureka_public         eureka_administrador    false    222         �           1259    18075    client_contract_id_township_idx    INDEX     i   CREATE INDEX client_contract_id_township_idx ON eureka_public.client_contract USING btree (id_township);
 :   DROP INDEX eureka_public.client_contract_id_township_idx;
       eureka_public         eureka_administrador    false    222         �           1259    18077 $   client_contract_id_type_contract_idx    INDEX     s   CREATE INDEX client_contract_id_type_contract_idx ON eureka_public.client_contract USING btree (id_type_contract);
 ?   DROP INDEX eureka_public.client_contract_id_type_contract_idx;
       eureka_public         eureka_administrador    false    222          	           1259    18105 (   client_contract_movement_id_contract_idx    INDEX     {   CREATE INDEX client_contract_movement_id_contract_idx ON eureka_public.client_contract_movement USING btree (id_contract);
 C   DROP INDEX eureka_public.client_contract_movement_id_contract_idx;
       eureka_public         eureka_administrador    false    224         	           1259    18107 *   client_contract_movement_movement_date_idx    INDEX     �   CREATE INDEX client_contract_movement_movement_date_idx ON eureka_public.client_contract_movement USING btree (eureka_public.custom_to_char_client_contract_movement_date(date));
 E   DROP INDEX eureka_public.client_contract_movement_movement_date_idx;
       eureka_public         eureka_administrador    false    284    224    224         	           1259    18108 %   client_contract_movement_movement_idx    INDEX     u   CREATE INDEX client_contract_movement_movement_idx ON eureka_public.client_contract_movement USING btree (movement);
 @   DROP INDEX eureka_public.client_contract_movement_movement_idx;
       eureka_public         eureka_administrador    false    224         �           1259    18008    client_id_street_idx    INDEX     S   CREATE INDEX client_id_street_idx ON eureka_public.client USING btree (id_street);
 /   DROP INDEX eureka_public.client_id_street_idx;
       eureka_public         eureka_administrador    false    217         �           1259    18006    client_id_town_idx    INDEX     O   CREATE INDEX client_id_town_idx ON eureka_public.client USING btree (id_town);
 -   DROP INDEX eureka_public.client_id_town_idx;
       eureka_public         eureka_administrador    false    217         �           1259    18007    client_id_township_idx    INDEX     W   CREATE INDEX client_id_township_idx ON eureka_public.client USING btree (id_township);
 1   DROP INDEX eureka_public.client_id_township_idx;
       eureka_public         eureka_administrador    false    217         �           1259    17923     employee_contact_id_employee_idx    INDEX     k   CREATE INDEX employee_contact_id_employee_idx ON eureka_public.employee_contact USING btree (id_employee);
 ;   DROP INDEX eureka_public.employee_contact_id_employee_idx;
       eureka_public         eureka_administrador    false    209         �           1259    17911    employee_id_street_idx    INDEX     W   CREATE INDEX employee_id_street_idx ON eureka_public.employee USING btree (id_street);
 1   DROP INDEX eureka_public.employee_id_street_idx;
       eureka_public         eureka_administrador    false    208         �           1259    17909    employee_id_town_idx    INDEX     S   CREATE INDEX employee_id_town_idx ON eureka_public.employee USING btree (id_town);
 /   DROP INDEX eureka_public.employee_id_town_idx;
       eureka_public         eureka_administrador    false    208         �           1259    17910    employee_id_township_idx    INDEX     [   CREATE INDEX employee_id_township_idx ON eureka_public.employee USING btree (id_township);
 3   DROP INDEX eureka_public.employee_id_township_idx;
       eureka_public         eureka_administrador    false    208         �           1259    17944    employee_user_id_employee_idx    INDEX     e   CREATE INDEX employee_user_id_employee_idx ON eureka_public.employee_user USING btree (id_employee);
 8   DROP INDEX eureka_public.employee_user_id_employee_idx;
       eureka_public         eureka_administrador    false    211         �           1259    17881    street_id_township_idx    INDEX     W   CREATE INDEX street_id_township_idx ON eureka_public.street USING btree (id_township);
 1   DROP INDEX eureka_public.street_id_township_idx;
       eureka_public         eureka_administrador    false    206         �           1259    17864    township_id_town_idx    INDEX     S   CREATE INDEX township_id_town_idx ON eureka_public.township USING btree (id_town);
 /   DROP INDEX eureka_public.township_id_town_idx;
       eureka_public         eureka_administrador    false    204         
	           2606    18171 C   employee_user_password employee_user_password_id_employee_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_private.employee_user_password
    ADD CONSTRAINT employee_user_password_id_employee_user_fkey FOREIGN KEY (id_employee_user) REFERENCES eureka_public.employee_user(id) ON DELETE CASCADE;
 u   ALTER TABLE ONLY eureka_private.employee_user_password DROP CONSTRAINT employee_user_password_id_employee_user_fkey;
       eureka_private       eureka_administrador    false    212    211    2277         	           2606    18087 2   business_contact business_contact_id_contract_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.business_contact
    ADD CONSTRAINT business_contact_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES eureka_public.client_contract(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY eureka_public.business_contact DROP CONSTRAINT business_contact_id_contract_fkey;
       eureka_public       eureka_administrador    false    2302    222    223         	           2606    18015 ,   client_contact client_contact_id_client_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contact
    ADD CONSTRAINT client_contact_id_client_fkey FOREIGN KEY (id_client) REFERENCES eureka_public.client(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY eureka_public.client_contact DROP CONSTRAINT client_contact_id_client_fkey;
       eureka_public       eureka_administrador    false    218    217    2287         	           2606    18069 .   client_contract client_contract_id_client_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_client_fkey FOREIGN KEY (id_client) REFERENCES eureka_public.client(id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_id_client_fkey;
       eureka_public       eureka_administrador    false    222    2287    217         	           2606    18059 .   client_contract client_contract_id_street_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);
 _   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_id_street_fkey;
       eureka_public       eureka_administrador    false    222    206    2266         	           2606    18049 ,   client_contract client_contract_id_town_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);
 ]   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_id_town_fkey;
       eureka_public       eureka_administrador    false    222    202    2256         	           2606    18054 0   client_contract client_contract_id_township_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);
 a   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_id_township_fkey;
       eureka_public       eureka_administrador    false    222    204    2261         	           2606    18064 5   client_contract client_contract_id_type_contract_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_type_contract_fkey FOREIGN KEY (id_type_contract) REFERENCES eureka_public.client_contract_type(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY eureka_public.client_contract DROP CONSTRAINT client_contract_id_type_contract_fkey;
       eureka_public       eureka_administrador    false    2290    220    222         	           2606    18100 B   client_contract_movement client_contract_movement_id_contract_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client_contract_movement
    ADD CONSTRAINT client_contract_movement_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES eureka_public.client_contract(id) ON DELETE CASCADE;
 s   ALTER TABLE ONLY eureka_public.client_contract_movement DROP CONSTRAINT client_contract_movement_id_contract_fkey;
       eureka_public       eureka_administrador    false    222    2302    224         	           2606    18001    client client_id_street_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);
 M   ALTER TABLE ONLY eureka_public.client DROP CONSTRAINT client_id_street_fkey;
       eureka_public       eureka_administrador    false    206    217    2266         	           2606    17991    client client_id_town_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);
 K   ALTER TABLE ONLY eureka_public.client DROP CONSTRAINT client_id_town_fkey;
       eureka_public       eureka_administrador    false    217    2256    202         	           2606    17996    client client_id_township_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);
 O   ALTER TABLE ONLY eureka_public.client DROP CONSTRAINT client_id_township_fkey;
       eureka_public       eureka_administrador    false    217    2261    204         	           2606    17918 2   employee_contact employee_contact_id_employee_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.employee_contact
    ADD CONSTRAINT employee_contact_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES eureka_public.employee(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY eureka_public.employee_contact DROP CONSTRAINT employee_contact_id_employee_fkey;
       eureka_public       eureka_administrador    false    208    209    2271         	           2606    17904     employee employee_id_street_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);
 Q   ALTER TABLE ONLY eureka_public.employee DROP CONSTRAINT employee_id_street_fkey;
       eureka_public       eureka_administrador    false    208    2266    206         	           2606    17894    employee employee_id_town_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);
 O   ALTER TABLE ONLY eureka_public.employee DROP CONSTRAINT employee_id_town_fkey;
       eureka_public       eureka_administrador    false    202    208    2256         	           2606    17899 "   employee employee_id_township_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);
 S   ALTER TABLE ONLY eureka_public.employee DROP CONSTRAINT employee_id_township_fkey;
       eureka_public       eureka_administrador    false    208    204    2261         		           2606    17939 ,   employee_user employee_user_id_employee_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES eureka_public.employee(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY eureka_public.employee_user DROP CONSTRAINT employee_user_id_employee_fkey;
       eureka_public       eureka_administrador    false    211    208    2271         	           2606    17876    street street_id_township_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.street
    ADD CONSTRAINT street_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY eureka_public.street DROP CONSTRAINT street_id_township_fkey;
       eureka_public       eureka_administrador    false    2261    204    206         	           2606    17859    township township_id_town_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY eureka_public.township DROP CONSTRAINT township_id_town_fkey;
       eureka_public       eureka_administrador    false    204    202    2256         �           3466    19090    postgraphile_watch_ddl    EVENT TRIGGER       CREATE EVENT TRIGGER postgraphile_watch_ddl ON ddl_command_end
         WHEN TAG IN ('ALTER AGGREGATE', 'ALTER DOMAIN', 'ALTER EXTENSION', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER POLICY', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE AGGREGATE', 'CREATE DOMAIN', 'CREATE EXTENSION', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE INDEX', 'CREATE POLICY', 'CREATE RULE', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP AGGREGATE', 'DROP DOMAIN', 'DROP EXTENSION', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP INDEX', 'DROP OWNED', 'DROP POLICY', 'DROP RULE', 'DROP SCHEMA', 'DROP TABLE', 'DROP TYPE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE PROCEDURE postgraphile_watch.notify_watchers_ddl();
 +   DROP EVENT TRIGGER postgraphile_watch_ddl;
             eureka_administrador    false    299         �           3466    19091    postgraphile_watch_drop    EVENT TRIGGER     y   CREATE EVENT TRIGGER postgraphile_watch_drop ON sql_drop
   EXECUTE PROCEDURE postgraphile_watch.notify_watchers_drop();
 ,   DROP EVENT TRIGGER postgraphile_watch_drop;
             eureka_administrador    false    300                                                  2458.dat                                                                                            0000600 0004000 0002000 00000000104 13504460374 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        $2a$08$FYKl78vHkI0/j5bVKqof3eb0lQkfGzK6e6Qf0G/Z0lLTRosb8lGoW	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                            2466.dat                                                                                            0000600 0004000 0002000 00000000037 13504460374 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        CELULAR	(111) 111 11 11	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 2460.dat                                                                                            0000600 0004000 0002000 00000000124 13504460374 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Miriam Guadalupe	Treviño	Villanueva	2	2	2	145	2019-04-25 19:44:04.689473-05
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                            2461.dat                                                                                            0000600 0004000 0002000 00000000066 13504460374 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        CELULAR	(111) 111 11 11	1
FIJO	(222) 222 22 22	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2465.dat                                                                                            0000600 0004000 0002000 00000000152 13504460374 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Miriam y Ángel 1	2	2	2	145	1	2019-04-25 19:45:05.784832-05	2019-05-25 19:45:05.784832-05	Activo	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                      2467.dat                                                                                            0000600 0004000 0002000 00000000054 13504460374 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2019-04-25 19:45:05.784832-05	Pagado	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    2463.dat                                                                                            0000600 0004000 0002000 00000000101 13504460374 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1 MES	1	150.00	Impuesto al Valor Agregado (IVA)	0.16	0.00
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                               2454.dat                                                                                            0000600 0004000 0002000 00000000115 13504460374 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	José de Jesús	Collazo	Reyes	1	1	1	123	2019-04-25 18:15:47.051612-05
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                   2455.dat                                                                                            0000600 0004000 0002000 00000000037 13504460374 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        CELULAR	(487) 111 11 11	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 2457.dat                                                                                            0000600 0004000 0002000 00000000043 13504460374 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Pepe	eureka_administrador	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             2452.dat                                                                                            0000600 0004000 0002000 00000000067 13504460374 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Gabríel Martínez	1
2	Molinos	2
3	Los Cholos	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                         2448.dat                                                                                            0000600 0004000 0002000 00000000061 13504460374 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Rioverde
2	Ciudad Fernández
3	El Refugio
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2450.dat                                                                                            0000600 0004000 0002000 00000000136 13504460374 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Colonia	Centro	79610	1
2	Infonativ	Casa Blanca	79651	2
3	Ampliación	El Barrio	12345	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                  restore.sql                                                                                         0000600 0004000 0002000 00000333041 13504460374 0015376 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE eureka;
--
-- Name: eureka; Type: DATABASE; Schema: -; Owner: eureka_administrador
--

CREATE DATABASE eureka WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_MX.UTF-8' LC_CTYPE = 'es_MX.UTF-8';


ALTER DATABASE eureka OWNER TO eureka_administrador;

\connect eureka

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: eureka_private; Type: SCHEMA; Schema: -; Owner: eureka_administrador
--

CREATE SCHEMA eureka_private;


ALTER SCHEMA eureka_private OWNER TO eureka_administrador;

--
-- Name: eureka_public; Type: SCHEMA; Schema: -; Owner: eureka_administrador
--

CREATE SCHEMA eureka_public;


ALTER SCHEMA eureka_public OWNER TO eureka_administrador;

--
-- Name: postgraphile_watch; Type: SCHEMA; Schema: -; Owner: eureka_administrador
--

CREATE SCHEMA postgraphile_watch;


ALTER SCHEMA postgraphile_watch OWNER TO eureka_administrador;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: jwt_token; Type: TYPE; Schema: eureka_private; Owner: eureka_administrador
--

CREATE TYPE eureka_private.jwt_token AS (
	role text,
	id_employee integer
);


ALTER TYPE eureka_private.jwt_token OWNER TO eureka_administrador;

--
-- Name: contact; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.contact AS (
	type_contact text,
	contact text
);


ALTER TYPE eureka_public.contact OWNER TO eureka_administrador;

--
-- Name: privileges_module; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.privileges_module AS (
	module text,
	privileges text
);


ALTER TYPE eureka_public.privileges_module OWNER TO eureka_administrador;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: employee; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.employee (
    id integer NOT NULL,
    name text NOT NULL,
    first_name text NOT NULL,
    last_name text,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE eureka_public.employee OWNER TO eureka_administrador;

--
-- Name: employee_user; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.employee_user (
    id integer NOT NULL,
    username text NOT NULL,
    role text NOT NULL,
    id_employee integer NOT NULL
);


ALTER TABLE eureka_public.employee_user OWNER TO eureka_administrador;

--
-- Name: TABLE employee_user; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.employee_user IS '@omit all';


--
-- Name: current_employee; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.current_employee AS (
	employee eureka_public.employee,
	employee_user eureka_public.employee_user,
	privileges_modules eureka_public.privileges_module[]
);


ALTER TYPE eureka_public.current_employee OWNER TO eureka_administrador;

--
-- Name: role_privileges; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.role_privileges AS (
	module text,
	add_modify boolean,
	delete boolean
);


ALTER TYPE eureka_public.role_privileges OWNER TO eureka_administrador;

--
-- Name: selected_employee; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.selected_employee AS (
	employee eureka_public.employee,
	employee_user eureka_public.employee_user
);


ALTER TYPE eureka_public.selected_employee OWNER TO eureka_administrador;

--
-- Name: selected_role; Type: TYPE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TYPE eureka_public.selected_role AS (
	role_name text,
	privileges eureka_public.privileges_module[]
);


ALTER TYPE eureka_public.selected_role OWNER TO eureka_administrador;

--
-- Name: client_contract_movement; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.client_contract_movement (
    date timestamp with time zone NOT NULL,
    movement text NOT NULL,
    id_contract integer
);


ALTER TABLE eureka_public.client_contract_movement OWNER TO eureka_administrador;

--
-- Name: TABLE client_contract_movement; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.client_contract_movement IS '@omit all';


--
-- Name: all_client_contract_movements(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.all_client_contract_movements(id_contract integer) RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE STRICT
    AS $_$
    SELECT 
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        id_contract = $1
    ORDER BY
        date
    DESC;
$_$;


ALTER FUNCTION eureka_public.all_client_contract_movements(id_contract integer) OWNER TO eureka_administrador;

--
-- Name: client_contract; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.client_contract (
    id integer NOT NULL,
    business text NOT NULL,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    id_type_contract integer NOT NULL,
    start_date timestamp with time zone DEFAULT now(),
    end_date timestamp with time zone NOT NULL,
    status text NOT NULL,
    id_client integer NOT NULL
);


ALTER TABLE eureka_public.client_contract OWNER TO eureka_administrador;

--
-- Name: TABLE client_contract; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.client_contract IS '@omit all';


--
-- Name: all_client_contracts(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.all_client_contracts(id_client integer) RETURNS SETOF eureka_public.client_contract
    LANGUAGE sql STABLE STRICT
    AS $_$
    SELECT
        *
    FROM
        eureka_public.client_contract
    WHERE
        id_client = $1
    ORDER BY
        start_date
    DESC;
$_$;


ALTER FUNCTION eureka_public.all_client_contracts(id_client integer) OWNER TO eureka_administrador;

--
-- Name: all_clients_debts(); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.all_clients_debts() RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE
    AS $$
    SELECT
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        movement
    LIKE
        'Adeudo'
    ORDER BY
        date
    DESC;
$$;


ALTER FUNCTION eureka_public.all_clients_debts() OWNER TO eureka_administrador;

--
-- Name: all_contracts_to_pay(); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.all_contracts_to_pay() RETURNS SETOF eureka_public.client_contract_movement
    LANGUAGE sql STABLE
    AS $$
    SELECT
        *
    FROM
        eureka_public.client_contract_movement
    WHERE
        DATE(date) = DATE(NOW())
    AND
        movement
    LIKE
        'Por Pagar'
    ORDER BY
        date
    DESC;
$$;


ALTER FUNCTION eureka_public.all_contracts_to_pay() OWNER TO eureka_administrador;

--
-- Name: all_roles(); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.all_roles() RETURNS SETOF text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        row RECORD;
    BEGIN
        FOR row IN 
            SELECT usename FROM pg_user WHERE usename ILIKE ('%' || 'eureka_' || '%') ORDER BY usename ASC
        LOOP
            RETURN NEXT row.usename;
        END LOOP;

        RETURN; 
    END;
$$;


ALTER FUNCTION eureka_public.all_roles() OWNER TO eureka_administrador;

--
-- Name: authenticate(text, text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.authenticate(username text, password text) RETURNS eureka_private.jwt_token
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        role TEXT;
        id_employee INTEGER;
        password_hash TEXT;
    BEGIN
        SELECT
            eureka_public.employee_user.role,
            eureka_public.employee_user.id_employee,
            eureka_private.employee_user_password.password_hash
        INTO
            role,
            id_employee,
            password_hash
        FROM
            eureka_public.employee_user
        INNER JOIN
            eureka_private.employee_user_password
        ON
            eureka_public.employee_user.id = eureka_private.employee_user_password.id_employee_user
        WHERE
            eureka_public.employee_user.username
        LIKE
            $1;

        IF password_hash = CRYPT($2, password_hash) THEN
            RETURN (role, id_employee)::eureka_private.jwt_token;
        ELSE
            RETURN NULL;
        END IF;
    END;
$_$;


ALTER FUNCTION eureka_public.authenticate(username text, password text) OWNER TO eureka_administrador;

--
-- Name: charge_month(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.charge_month(id_contract integer) RETURNS eureka_public.client_contract_movement
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.client_contract
    SET
        status = 'Activo'
    WHERE
        id = $1;

    UPDATE
        eureka_public.client_contract_movement
    SET
        date = NOW(),
        movement = 'Pagado'
    WHERE
        TO_CHAR(date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY')
    AND
        id_contract = $1
    RETURNING
        *;
$_$;


ALTER FUNCTION eureka_public.charge_month(id_contract integer) OWNER TO eureka_administrador;

--
-- Name: client_contract_formated_end_date(eureka_public.client_contract); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_formated_end_date(contract eureka_public.client_contract) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract.end_date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;


ALTER FUNCTION eureka_public.client_contract_formated_end_date(contract eureka_public.client_contract) OWNER TO eureka_administrador;

--
-- Name: client_contract_formated_start_date(eureka_public.client_contract); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_formated_start_date(contract eureka_public.client_contract) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract.start_date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;


ALTER FUNCTION eureka_public.client_contract_formated_start_date(contract eureka_public.client_contract) OWNER TO eureka_administrador;

--
-- Name: client_contract_full_address(eureka_public.client_contract); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_full_address(client_contract_table eureka_public.client_contract) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.client_contract.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.client_contract
        ON
            eureka_public.town.id = eureka_public.client_contract.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.client_contract.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.client_contract.id_street
        WHERE
            eureka_public.client_contract.id = client_contract_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;


ALTER FUNCTION eureka_public.client_contract_full_address(client_contract_table eureka_public.client_contract) OWNER TO eureka_administrador;

--
-- Name: client_contract_movement_formated_movement_date(eureka_public.client_contract_movement); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_movement_formated_movement_date(contract_movement eureka_public.client_contract_movement) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT TO_CHAR(contract_movement.date, 'TMDay, dd "de" TMMonth "de" YYYY');
$$;


ALTER FUNCTION eureka_public.client_contract_movement_formated_movement_date(contract_movement eureka_public.client_contract_movement) OWNER TO eureka_administrador;

--
-- Name: client_contract_type; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.client_contract_type (
    id integer NOT NULL,
    type_name text NOT NULL,
    number_months integer NOT NULL,
    month_price numeric NOT NULL,
    tax_type text NOT NULL,
    tax_percentage numeric NOT NULL,
    discount_percentage numeric NOT NULL
);


ALTER TABLE eureka_public.client_contract_type OWNER TO eureka_administrador;

--
-- Name: COLUMN client_contract_type.tax_percentage; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON COLUMN eureka_public.client_contract_type.tax_percentage IS '@omit';


--
-- Name: COLUMN client_contract_type.discount_percentage; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON COLUMN eureka_public.client_contract_type.discount_percentage IS '@omit';


--
-- Name: client_contract_type_discount_percentage(eureka_public.client_contract_type); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_type_discount_percentage(contract_type eureka_public.client_contract_type) RETURNS numeric
    LANGUAGE sql STABLE
    AS $$
    SELECT FLOOR(contract_type.discount_percentage * 100);
$$;


ALTER FUNCTION eureka_public.client_contract_type_discount_percentage(contract_type eureka_public.client_contract_type) OWNER TO eureka_administrador;

--
-- Name: client_contract_type_tax_percentage(eureka_public.client_contract_type); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_type_tax_percentage(contract_type eureka_public.client_contract_type) RETURNS numeric
    LANGUAGE sql STABLE
    AS $$
    SELECT FLOOR(contract_type.tax_percentage * 100);
$$;


ALTER FUNCTION eureka_public.client_contract_type_tax_percentage(contract_type eureka_public.client_contract_type) OWNER TO eureka_administrador;

--
-- Name: client_contract_type_total(eureka_public.client_contract_type); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_contract_type_total(type_contract eureka_public.client_contract_type) RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        sub_total NUMERIC;
        iva NUMERIC;
        monthly_payment NUMERIC;
    BEGIN
        IF type_contract.discount_percentage > 0 THEN
            sub_total := ((type_contract.number_months * type_contract.month_price) * type_contract.discount_percentage);
        ELSE
            sub_total := (type_contract.number_months * type_contract.month_price);
        END IF;

        iva := sub_total * type_contract.tax_percentage;
        monthly_payment := ROUND(sub_total + iva, 2);

        RETURN monthly_payment;
    END;
$$;


ALTER FUNCTION eureka_public.client_contract_type_total(type_contract eureka_public.client_contract_type) OWNER TO eureka_administrador;

--
-- Name: client; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.client (
    id integer NOT NULL,
    name text NOT NULL,
    first_name text NOT NULL,
    last_name text,
    id_town integer NOT NULL,
    id_township integer NOT NULL,
    id_street integer NOT NULL,
    exterior_number character varying(5) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE eureka_public.client OWNER TO eureka_administrador;

--
-- Name: client_full_address(eureka_public.client); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_full_address(client_table eureka_public.client) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.client.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.client
        ON
            eureka_public.town.id = eureka_public.client.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.client.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.client.id_street
        WHERE
            eureka_public.client.id = client_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;


ALTER FUNCTION eureka_public.client_full_address(client_table eureka_public.client) OWNER TO eureka_administrador;

--
-- Name: client_full_name(eureka_public.client); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.client_full_name(client eureka_public.client) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT client.name || ' ' || client.first_name || ' ' || client.last_name;
$$;


ALTER FUNCTION eureka_public.client_full_name(client eureka_public.client) OWNER TO eureka_administrador;

--
-- Name: collect_contract_debt(timestamp with time zone, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.collect_contract_debt(date_of_debt timestamp with time zone, id_contract integer) RETURNS void
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        updated_contract_movement eureka_public.client_contract_movement;
        contract eureka_public.client_contract;
    BEGIN
        UPDATE
            eureka_public.client_contract_movement
        SET
            date = NOW(),
            movement = 'Pagado'
        WHERE
            eureka_public.client_contract_movement.date = $1
        AND
            eureka_public.client_contract_movement.id_contract = $2
        RETURNING
            *
        INTO
            updated_contract_movement;

        SELECT
            *
        FROM
            eureka_public.client_contract
        WHERE
            id = $2
        INTO
            contract;

        IF NOT EXISTS(
            SELECT
                1
            FROM
                eureka_public.client_contract_movement
            WHERE
                eureka_public.client_contract_movement.movement = 'Adeudo'
            AND
                eureka_public.client_contract_movement.id_contract = $2
        ) THEN
            IF EXISTS (
                SELECT
                    *
                FROM
                    eureka_public.client_contract_movement
                WHERE
                    eureka_public.client_contract_movement.date
                BETWEEN
                    contract.start_date
                AND
                    contract.end_date
                AND
                    eureka_public.client_contract_movement.movement = 'Por Pagar'
                AND
                    eureka_public.client_contract_movement.id_contract = $2
            ) THEN
                UPDATE eureka_public.client_contract SET status = 'Activo' WHERE id = $2;
            ELSEIF (
                TO_CHAR(NOW(), 'DD-MM-YYYY') < TO_CHAR(contract.end_date, 'DD-MM-YYYY')
            ) THEN
                UPDATE eureka_public.client_contract SET status = 'Activo' WHERE id = $2;
            ELSE
                UPDATE eureka_public.client_contract SET status = 'Finalizado' WHERE id = $2;
            END IF;
        END IF;

        RETURN;
    END;
$_$;


ALTER FUNCTION eureka_public.collect_contract_debt(date_of_debt timestamp with time zone, id_contract integer) OWNER TO eureka_administrador;

--
-- Name: create_client(text, text, text, integer, integer, integer, text, eureka_public.contact[]); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[]) RETURNS eureka_public.client
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        created_client eureka_public.client;
        client_contact eureka_public.contact;
    BEGIN
        IF EXISTS (
            SELECT
                1
            FROM
                eureka_public.client
            WHERE
                UNACCENT(eureka_public.client.name)
            LIKE
                UNACCENT($1)
            AND
                UNACCENT(eureka_public.client.first_name)
            LIKE
                UNACCENT($2)
            AND
                UNACCENT(eureka_public.client.last_name)
            LIKE
                UNACCENT($3)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || $1 || ' ' || $2 || ' ' || $3 || ' ya fue registrado.',
                HINT = 'Cliente ya Registrado';
        ELSE
            INSERT INTO eureka_public.client(
                name,
                first_name,
                last_name,
                id_town,
                id_township,
                id_street,
                exterior_number
            ) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING * INTO created_client;
            
            IF ARRAY_LENGTH($8, 1) > 0 THEN
                FOREACH client_contact IN ARRAY $8 LOOP
                    INSERT INTO eureka_public.client_contact(
                        type_contact,
                        contact,
                        id_client
                    ) VALUES(
                        client_contact.type_contact,
                        client_contact.contact,
                        created_client.id
                    );
                END LOOP;
            END IF;
        END IF;

        RETURN created_client;
    END;
$_$;


ALTER FUNCTION eureka_public.create_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[]) OWNER TO eureka_administrador;

--
-- Name: create_client_contract(text, integer, integer, integer, text, integer, eureka_public.contact[], integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id_client integer) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        months_quantity INTEGER;
        created_client_contract eureka_public.client_contract;
        business_contact eureka_public.contact;
        counter INTEGER := 0;
    BEGIN
        IF EXISTS(
            SELECT
                1
            FROM
                eureka_public.client_contract
            WHERE
                UNACCENT(eureka_public.client_contract.business)
            LIKE
                UNACCENT($1)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El contrato para el Negocio ' || $1 || ' ya fue registrado.',
                HINT = 'Contrato ya Registrado';
        ELSE
            SELECT number_months FROM eureka_public.client_contract_type WHERE id = $6 INTO months_quantity;

            INSERT INTO eureka_public.client_contract(
                business,
                id_town,
                id_township,
                id_street,
                exterior_number,
                id_type_contract,
                end_date,
                status,
                id_client
            ) VALUES(
                $1,
                $2,
                $3,
                $4,
                $5,
                $6,
                NOW() + (months_quantity || ' MONTHS')::INTERVAL,
                'Activo',
                $8
            ) RETURNING * INTO created_client_contract;

            IF ARRAY_LENGTH($7, 1) > 0 THEN
                FOREACH business_contact IN ARRAY $7 LOOP
                    INSERT INTO eureka_public.business_contact(
                        type_contact,
                        contact,
                        id_contract
                    ) VALUES(
                        business_contact.type_contact,
                        business_contact.contact,
                        created_client_contract.id
                    );
                END LOOP;
            END IF;

            FOR counter IN 1..months_quantity LOOP
                IF counter = 1 THEN
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        created_client_contract.start_date,
                        'Pagado',
                        created_client_contract.id
                    );
                ELSE
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        created_client_contract.start_date + (counter - 1 || ' MONTHS')::INTERVAL,
                        'Por Pagar',
                        created_client_contract.id
                    );
                END IF;
            END LOOP;
        END IF;

        RETURN created_client_contract;
    END;
$_$;


ALTER FUNCTION eureka_public.create_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id_client integer) OWNER TO eureka_administrador;

--
-- Name: create_client_contract_type(text, integer, numeric, text, numeric, numeric); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric) RETURNS eureka_public.client_contract_type
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_client_contract_type eureka_public.client_contract_type;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.client_contract_type WHERE eureka_public.client_contract_type.type_name LIKE $1) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato ' || $1 || ' ya fue registrado.',
                HINT = 'Tipo de Contrato ya Registrado';
        ELSE
            INSERT INTO eureka_public.client_contract_type(
                type_name,
                number_months,
                month_price,
                tax_type,
                tax_percentage,
                discount_percentage
            ) VALUES(
                $1,
                $2,
                $3,
                $4,
                ROUND($5 / 100::NUMERIC, 2),
                ROUND($6 / 100::NUMERIC, 2)
            ) RETURNING
                *
            INTO
                created_client_contract_type;
        END IF;

        RETURN created_client_contract_type;
    END;
$_$;


ALTER FUNCTION eureka_public.create_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric) OWNER TO eureka_administrador;

--
-- Name: create_employee(text, text, text, integer, integer, integer, text, eureka_public.contact[], text, text, text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, password text, role text) RETURNS eureka_public.employee
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        created_employee eureka_public.employee;
        employee_contact eureka_public.contact;
    BEGIN
        IF EXISTS (
            SELECT
                1
            FROM
                eureka_public.employee
            WHERE
                UNACCENT(eureka_public.employee.name)
            LIKE
                UNACCENT($1)
            AND
                UNACCENT(eureka_public.employee.first_name)
            LIKE
                UNACCENT($2)
            AND
                UNACCENT(eureka_public.employee.last_name)
            LIKE
                UNACCENT($3)
        ) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El empleado ' || $1 || ' ' || $2 || ' ' || $3 || ' ya fue registrado.',
                HINT = 'Empleado ya Registrado';
        ELSE
            IF EXISTS (
                SELECT
                    1
                FROM
                    eureka_private.user
                WHERE
                    UNACCENT(eureka_private.user.username)
                ILIKE
                    UNACCENT($9)
            ) THEN
                RAISE EXCEPTION USING 
                    MESSAGE = 'El nombre de usuario ' || $9 || ' ya fue registrado por otro empleado.',
                    HINT = 'Nombre de Usuario ya Registrado';
            ELSE
                INSERT INTO eureka_public.employee(
                    name,
                    first_name,
                    last_name,
                    id_town,
                    id_township,
                    id_street,
                    exterior_number
                ) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING * INTO created_employee;

                IF ARRAY_LENGTH($8, 1) > 0 THEN
                    FOREACH employee_contact IN ARRAY $8 LOOP
                        INSERT INTO eureka_public.employee_contact(
                            type_contact,
                            contact,
                            id_employee
                        ) VALUES(
                            employee_contact.type_contact,
                            employee_contact.contact,
                            created_employee.id
                        );
                    END LOOP;
                END IF;

                INSERT INTO eureka_private.user(
                    username,
                    password,
                    role,
                    id_employee
                ) VALUES(
                    $9,
                    CRYPT($10, GEN_SALT('BF', 8)),
                    $11,
                    created_employee.id
                );
            END IF;
        END IF;

        RETURN created_employee;
    END;
$_$;


ALTER FUNCTION eureka_public.create_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, password text, role text) OWNER TO eureka_administrador;

--
-- Name: create_role(text, eureka_public.role_privileges[]); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_role(role_name text, role_privileges eureka_public.role_privileges[]) RETURNS text
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        privileges eureka_public.role_privileges;
    BEGIN
        IF (SELECT 1 FROM pg_user WHERE usename ILIKE ('%' || 'eureka_' || LOWER($1) || '%')) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'Ese rol ya fue registrado.',
                HINT = 'Rol ya Registrado';
        ELSE
            EXECUTE 'CREATE ROLE ' || 'eureka_' || LOWER($1) || ' WITH LOGIN ENCRYPTED PASSWORD ' || 'eureka_' || LOWER($1) || ';';
            
            EXECUTE
                'GRANT ' || 'eureka_' || LOWER($1) || ' TO eureka_administrador;' ||
                'GRANT CONNECT ON DATABASE eureka TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE ON SCHEMA eureka_public TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE ON SCHEMA eureka_private TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA eureka_public TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA eureka_private TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee_user TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_private.employee_user_password TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.authenticate TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.current_employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.employee_full_name TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.employee_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_town TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.township TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_township TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_township TO ' || 'eureka_' || LOWER($1) || ';' || 
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.create_street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.modify_street TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE eureka_public.client_contract_movement TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.all_client_contracts TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.client_contract_type TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT SELECT ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_full_name TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.custom_to_char_client_contract_movement_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_full_address TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_formated_start_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.client_contract_formated_end_date TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.update_contracts_status TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.all_contracts_to_pay TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.charge_month TO ' || 'eureka_' || LOWER($1) || ';' ||
                'GRANT EXECUTE ON FUNCTION eureka_public.pay_and_renovate_client_contract TO ' || 'eureka_' || LOWER($1) || ';';
            FOREACH privileges IN ARRAY $2 LOOP
                IF privileges.module = 'Clients' THEN
                    IF privileges.add_modify THEN
                        EXECUTE
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';

                    END IF;

                    IF privileges.delete THEN
                        EXECUTE
                            'GRANT DELETE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;
                ELSEIF privileges.module = 'Employees' THEN
                    IF privileges.add_modify THEN
                        EXECUTE
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT INSERT, UPDATE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;

                    IF privileges.delete THEN
                        EXECUTE
                            'GRANT DELETE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                            'GRANT DELETE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                    END IF;
                END IF;
            END LOOP;
        END IF;

        RETURN 'eureka_' || $1;
    END;
$_$;


ALTER FUNCTION eureka_public.create_role(role_name text, role_privileges eureka_public.role_privileges[]) OWNER TO eureka_administrador;

--
-- Name: street; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.street (
    id integer NOT NULL,
    street text NOT NULL,
    id_township integer NOT NULL
);


ALTER TABLE eureka_public.street OWNER TO eureka_administrador;

--
-- Name: create_street(text, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_street(street text, id_township integer) RETURNS eureka_public.street
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_street eureka_public.street;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.street WHERE UNACCENT(eureka_public.street.street) LIKE UNACCENT($1) AND eureka_public.street.id_township = $2) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'La Calle ' || $1 || ' ya fue registrada.',
                HINT = 'Calle ya Registrada';
        ELSE
            INSERT INTO eureka_public.street(street, id_township) VALUES($1, $2) RETURNING * INTO created_street;
        END IF;

        RETURN created_street;
    END;
$_$;


ALTER FUNCTION eureka_public.create_street(street text, id_township integer) OWNER TO eureka_administrador;

--
-- Name: town; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.town (
    id integer NOT NULL,
    town text NOT NULL
);


ALTER TABLE eureka_public.town OWNER TO eureka_administrador;

--
-- Name: create_town(text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_town(town text) RETURNS eureka_public.town
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_town eureka_public.town;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.town WHERE UNACCENT(eureka_public.town.town) LIKE UNACCENT($1)) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'La ciudad ' || $1 || ' ya fue registrada.',
                HINT = 'Ciudad ya Registrada';
        ELSE
            INSERT INTO eureka_public.town(town) VALUES($1) RETURNING * INTO created_town;
        END IF;

        RETURN created_town;
    END;
$_$;


ALTER FUNCTION eureka_public.create_town(town text) OWNER TO eureka_administrador;

--
-- Name: township; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.township (
    id integer NOT NULL,
    type_township text NOT NULL,
    township text NOT NULL,
    postal_code text NOT NULL,
    id_town integer NOT NULL
);


ALTER TABLE eureka_public.township OWNER TO eureka_administrador;

--
-- Name: create_township(text, text, text, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.create_township(type_township text, township text, postal_code text, id_town integer) RETURNS eureka_public.township
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        created_township eureka_public.township;
    BEGIN
        IF EXISTS (SELECT 1 FROM eureka_public.township WHERE UNACCENT(eureka_public.township.township) LIKE UNACCENT($2) AND eureka_public.township.id_town = $4) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Asentamiento ' || $2 || ' ya fue registrado.',
                HINT = 'Asentamiento ya Registrado';
        ELSE
            INSERT INTO eureka_public.township(
                type_township,
                township,
                postal_code,
                id_town
            ) VALUES($1, $2, $3, $4) RETURNING
                *
            INTO
                created_township;
        END IF;

        RETURN created_township;
    END;
$_$;


ALTER FUNCTION eureka_public.create_township(type_township text, township text, postal_code text, id_town integer) OWNER TO eureka_administrador;

--
-- Name: current_employee(); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.current_employee() RETURNS eureka_public.current_employee
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        employee eureka_public.employee;
        employee_user eureka_public.employee_user;
        privileges_module eureka_public.privileges_module;
        privileges_employee eureka_public.privileges_module[];
    BEGIN
        SELECT
            *
        FROM
            eureka_public.employee
        WHERE
            id = CURRENT_SETTING('jwt.claims.id_employee')::INTEGER
        INTO
            employee;

        SELECT
            *
        FROM
            eureka_public.employee_user
        WHERE
            id_employee = CURRENT_SETTING('jwt.claims.id_employee')::INTEGER
        INTO
            employee_user;
        
        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || CURRENT_SETTING('jwt.claims.role')::TEXT || '%')
            GROUP BY
                table_name
        LOOP
            privileges_employee := ARRAY_APPEND(privileges_employee, privileges_module);
        END LOOP;

        RETURN (employee, employee_user, privileges_employee)::eureka_public.current_employee;
    END;
$$;


ALTER FUNCTION eureka_public.current_employee() OWNER TO eureka_administrador;

--
-- Name: custom_to_char_client_contract_end_date(timestamp with time zone); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
    SELECT TO_CHAR($1, 'DD-MM-YYYY');
$_$;


ALTER FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone) OWNER TO eureka_administrador;

--
-- Name: FUNCTION custom_to_char_client_contract_end_date(timestamp with time zone); Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON FUNCTION eureka_public.custom_to_char_client_contract_end_date(timestamp with time zone) IS '@omit';


--
-- Name: custom_to_char_client_contract_movement_date(timestamp with time zone); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
    SELECT TO_CHAR($1, 'MM-YYYY');
$_$;


ALTER FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone) OWNER TO eureka_administrador;

--
-- Name: FUNCTION custom_to_char_client_contract_movement_date(timestamp with time zone); Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON FUNCTION eureka_public.custom_to_char_client_contract_movement_date(timestamp with time zone) IS '@omit';


--
-- Name: delete_client(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.delete_client(id integer) RETURNS eureka_public.client
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        selected_id_contract INTEGER;
        client eureka_public.client;
    BEGIN
        SELECT
            eureka_public.client_contract.id
        FROM
            eureka_public.client_contract
        WHERE
            id_client = $1
        INTO
            selected_id_contract;

        SELECT * FROM eureka_public.client WHERE eureka_public.client.id = $1 INTO client;

        IF EXISTS (SELECT * FROM eureka_public.client_contract WHERE eureka_public.client_contract.id_client = client.id AND status LIKE 'Activo') THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || client.name || ' ' || client.first_name || ' ' || client.last_name || ' no puede ser eliminado pues cuenta con contratos que aun no han finalizado.',
                HINT = 'Contrato aun Activo';
        ELSEIF EXISTS (SELECT * FROM eureka_public.client_contract_movement WHERE eureka_public.client_contract_movement.movement LIKE 'Adeudo' AND eureka_public.client_contract_movement.id_contract = selected_id_contract) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El cliente ' || client.name || ' ' || client.first_name || ' ' || client.last_name || ' no puede ser eliminado pues tiene adeudos pendientes.',
                HINT = 'Adeudos Pendientes';
        ELSE
            DELETE FROM eureka_public.client WHERE eureka_public.client.id = $1;
        END IF;

        RETURN client;
    END;
$_$;


ALTER FUNCTION eureka_public.delete_client(id integer) OWNER TO eureka_administrador;

--
-- Name: delete_client_contract(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.delete_client_contract(id integer) RETURNS eureka_public.client_contract
    LANGUAGE sql STRICT
    AS $_$
    DELETE FROM
        eureka_public.client_contract
    WHERE
        eureka_public.client_contract.id = $1
    RETURNING *;
$_$;


ALTER FUNCTION eureka_public.delete_client_contract(id integer) OWNER TO eureka_administrador;

--
-- Name: delete_client_contract_type(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.delete_client_contract_type(id integer) RETURNS eureka_public.client_contract_type
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        deleted_client_contract_type eureka_public.client_contract_type;
    BEGIN
        IF (SELECT 1 FROM eureka_public.client_contract WHERE eureka_public.client_contract.id_type_contract = $1) THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'Existe un contrato que tiene asignado este tipo de contrato, primero, debes de eliminar estos contratos.',
                HINT = 'No se puede eliminar este tipo de contrato';
        ELSE
            DELETE FROM
                eureka_public.client_contract_type
            WHERE
                eureka_public.client_contract_type.id = $1
            RETURNING
                *
            INTO
                deleted_client_contract_type;
        END IF;

        RETURN deleted_client_contract_type;
    END;
$_$;


ALTER FUNCTION eureka_public.delete_client_contract_type(id integer) OWNER TO eureka_administrador;

--
-- Name: delete_employee(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.delete_employee(id integer) RETURNS eureka_public.employee
    LANGUAGE sql STRICT
    AS $_$
    DELETE FROM
        eureka_public.employee
    WHERE
        eureka_public.employee.id = $1
    RETURNING *;
$_$;


ALTER FUNCTION eureka_public.delete_employee(id integer) OWNER TO eureka_administrador;

--
-- Name: delete_role(text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.delete_role(role_name text) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        formated_role_name TEXT;
    BEGIN
        IF EXISTS(SELECT * FROM eureka_public.employee_user WHERE role LIKE $1) THEN
            formated_role_name = INITCAP(REPLACE($1, 'eureka_', ''));

            RAISE EXCEPTION USING 
                MESSAGE = 'El rol ' || formated_role_name || ' no puede ser eliminado porque fue asignado a un empleado, primero, elimine a todos los empleados que cuenten con este rol asignado.',
                HINT = 'No se puede eliminar el Rol';
        ELSE
            EXECUTE
                'REVOKE ' || $1 || ' FROM eureka_administrador;' ||
                'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL SEQUENCES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL SEQUENCES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL FUNCTIONS IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL FUNCTIONS IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL TABLES IN SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA eureka_public  FROM ' || $1 || ';' ||
                'REVOKE ALL ON ALL TABLES IN SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE USAGE ON SCHEMA eureka_private FROM ' || $1 || ';' ||
                'REVOKE USAGE ON SCHEMA eureka_public FROM ' || $1 || ';' ||
                'REVOKE CONNECT ON DATABASE eureka FROM ' || $1 || ';' ||
                'DROP ROLE ' || $1 || ';';
        END IF;

        RETURN $1;
    END;
$_$;


ALTER FUNCTION eureka_public.delete_role(role_name text) OWNER TO eureka_administrador;

--
-- Name: employee_by_id(integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.employee_by_id(id integer) RETURNS eureka_public.selected_employee
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
    DECLARE
        employee eureka_public.employee;
        employee_user eureka_public.employee_user;
        selected_employee eureka_public.selected_employee;
    BEGIN
        SELECT
            *
        FROM
            eureka_public.employee
        WHERE
            eureka_public.employee.id = $1
        INTO
            employee;

        SELECT
            *
        FROM
            eureka_public.employee_user
        WHERE
            eureka_public.employee_user.id_employee = $1
        INTO
            employee_user;

        selected_employee = (employee, employee_user)::eureka_public.selected_employee;

        RETURN selected_employee;
    END;
$_$;


ALTER FUNCTION eureka_public.employee_by_id(id integer) OWNER TO eureka_administrador;

--
-- Name: employee_full_address(eureka_public.employee); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.employee_full_address(employee_table eureka_public.employee) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        town TEXT;
        type_township TEXT;
        township TEXT;
        street TEXT;
        exterior_number TEXT;
        full_address TEXT;
    BEGIN
        SELECT
            eureka_public.town.town,
            eureka_public.township.type_township,
            eureka_public.township.township,
            eureka_public.street.street,
            eureka_public.employee.exterior_number
        INTO
            town,
            type_township,
            township,
            street,
            exterior_number
        FROM
            eureka_public.town
        INNER JOIN
            eureka_public.employee
        ON
            eureka_public.town.id = eureka_public.employee.id_town
        INNER JOIN
            eureka_public.township
        ON
            eureka_public.township.id = eureka_public.employee.id_township
        INNER JOIN
            eureka_public.street
        ON
            eureka_public.street.id = eureka_public.employee.id_street
        WHERE
            eureka_public.employee.id = employee_table.id;

        full_address := street || ' #' || exterior_number || ', ' || type_township || ' ' || township || ', ' || town;

        RETURN full_address;
    END;
$$;


ALTER FUNCTION eureka_public.employee_full_address(employee_table eureka_public.employee) OWNER TO eureka_administrador;

--
-- Name: employee_full_name(eureka_public.employee); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.employee_full_name(employee eureka_public.employee) RETURNS text
    LANGUAGE sql STABLE
    AS $$
    SELECT employee.name || ' ' || employee.first_name || ' ' || employee.last_name;
$$;


ALTER FUNCTION eureka_public.employee_full_name(employee eureka_public.employee) OWNER TO eureka_administrador;

--
-- Name: modify_client(text, text, text, integer, integer, integer, text, eureka_public.contact[], integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], id integer) RETURNS eureka_public.client
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        modified_client eureka_public.client;
        client_contact eureka_public.contact;
    BEGIN
        UPDATE
            eureka_public.client
        SET
            name = $1,
            first_name = $2,
            last_name = $3,
            id_town = $4,
            id_township = $5,
            id_street = $6,
            exterior_number = $7
        WHERE
            client.id = $9
        RETURNING
            *
        INTO
            modified_client;

        DELETE FROM eureka_public.client_contact WHERE id_client = $9;
        
        IF ARRAY_LENGTH($8, 1) > 0 THEN
            FOREACH client_contact IN ARRAY $8 LOOP
                INSERT INTO eureka_public.client_contact(
                    type_contact,
                    contact,
                    id_client
                ) VALUES(
                    client_contact.type_contact,
                    client_contact.contact,
                    $9
                );
            END LOOP;
        END IF;

        RETURN modified_client;
    END;
$_$;


ALTER FUNCTION eureka_public.modify_client(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], id integer) OWNER TO eureka_administrador;

--
-- Name: modify_client_contract(text, integer, integer, integer, text, integer, eureka_public.contact[], integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id integer) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        selected_client_contract eureka_public.client_contract;
        months_quantity INTEGER;
        modified_client_contract eureka_public.client_contract;
        business_contact eureka_public.contact;
    BEGIN
        SELECT * FROM eureka_public.client_contract WHERE eureka_public.client_contract.id = $8 INTO selected_client_contract;
        SELECT number_months FROM eureka_public.client_contract_type WHERE eureka_public.client_contract_type.id = $6 INTO months_quantity;

        IF $6 <> selected_client_contract.id_type_contract AND selected_client_contract.status = 'Por Pagar' THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato no puede ser modificado, pues este contrato esta por realizar su pago correspondiente.',
                HINT = 'Pago Pendiente';
        ELSEIF $6 <> selected_client_contract.id_type_contract AND selected_client_contract.status = 'Adeudo' THEN
            RAISE EXCEPTION USING 
                MESSAGE = 'El Tipo de Contrato no puede ser modificado, pues este contrato tiene adeudos pendientes.',
                HINT = 'Adeudos Pendiente';
        ELSE
            UPDATE
                eureka_public.client_contract
            SET
                business = $1,
                id_town = $2,
                id_township = $3,
                id_street = $4,
                exterior_number = $5,
                id_type_contract = $6,
                end_date = start_date + (months_quantity || ' MONTHS')::INTERVAL
            WHERE
                eureka_public.client_contract.id = $8
            RETURNING * INTO modified_client_contract;

            DELETE FROM eureka_public.business_contact WHERE eureka_public.business_contact.id_contract = $8;

            IF ARRAY_LENGTH($7, 1) > 0 THEN
                FOREACH business_contact IN ARRAY $7 LOOP
                    INSERT INTO eureka_public.business_contact(
                        type_contact,
                        contact,
                        id_contract
                    ) VALUES(
                        business_contact.type_contact,
                        business_contact.contact,
                        modified_client_contract.id
                    );
                END LOOP;
            END IF;

            DELETE FROM eureka_public.client_contract_movement WHERE eureka_public.client_contract_movement.date BETWEEN selected_client_contract.start_date AND selected_client_contract.end_date AND eureka_public.client_contract_movement.id_contract = $8;

            FOR counter IN 1..months_quantity LOOP
                IF counter = 1 THEN
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        modified_client_contract.start_date,
                        'Pagado',
                        modified_client_contract.id
                    );
                ELSE
                    INSERT INTO eureka_public.client_contract_movement(
                        date,
                        movement,
                        id_contract
                    ) VALUES(
                        modified_client_contract.start_date + ('3 DAYS ' || counter - 1 || ' MONTHS')::INTERVAL,
                        'Por Pagar',
                        modified_client_contract.id
                    );
                END IF;
            END LOOP;
        END IF;

        RETURN modified_client_contract;
    END;
$_$;


ALTER FUNCTION eureka_public.modify_client_contract(business text, id_town integer, id_township integer, id_street integer, exterior_number text, id_type_contract integer, contacts eureka_public.contact[], id integer) OWNER TO eureka_administrador;

--
-- Name: modify_client_contract_type(text, integer, numeric, text, numeric, numeric, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric, id integer) RETURNS eureka_public.client_contract_type
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.client_contract_type
    SET
        type_name = $1,
        number_months = $2,
        month_price = $3, 
        tax_type = $4,
        tax_percentage = ROUND($5 / 100::NUMERIC, 2),
        discount_percentage = ROUND($6 / 100::NUMERIC, 2)
    WHERE
        id = $7
    RETURNING
        *;
$_$;


ALTER FUNCTION eureka_public.modify_client_contract_type(type_name text, number_months integer, month_price numeric, tax_type text, tax_percentage numeric, discount_percentage numeric, id integer) OWNER TO eureka_administrador;

--
-- Name: modify_employee(text, text, text, integer, integer, integer, text, eureka_public.contact[], text, text, integer, text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, role text, id integer, password text DEFAULT 'REEMPLAZAME'::text) RETURNS eureka_public.selected_employee
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        modified_employee eureka_public.employee;
        employee_contact eureka_public.contact;
        employee_user eureka_public.employee_user;
        selected_employee eureka_public.selected_employee;
    BEGIN
        UPDATE
            eureka_public.employee
        SET
            name = $1,
            first_name = $2,
            last_name = $3,
            id_town = $4,
            id_township = $5,
            id_street = $6,
            exterior_number = $7
        WHERE
            eureka_public.employee.id = $11
        RETURNING * INTO modified_employee;

        DELETE FROM eureka_public.employee_contact WHERE eureka_public.employee_contact.id_employee = $11;

        IF ARRAY_LENGTH($8, 1) > 0 THEN
            FOREACH employee_contact IN ARRAY $8 LOOP
                INSERT INTO eureka_public.employee_contact(
                    type_contact,
                    contact,
                    id_employee
                ) VALUES(
                    employee_contact.type_contact,
                    employee_contact.contact,
                    $11
                );
            END LOOP;
        END IF;

        UPDATE
            eureka_public.employee_user
        SET
            username = $9,
            role = $10
        WHERE
            eureka_public.employee_user.id_employee = $11
        RETURNING 
            *
        INTO
            employee_user;

        IF $12 <> 'REEMPLAZAME' THEN
            UPDATE 
                eureka_private.employee_user_password
            SET
                password_hash = CRYPT($12, GEN_SALT('BF', 8))
            WHERE
                eureka_private.employee_user_password.id_employee_user = $11;
        END IF;

        selected_employee = (modified_employee, employee_user)::eureka_public.selected_employee;

        RETURN selected_employee;
    END;
$_$;


ALTER FUNCTION eureka_public.modify_employee(name text, first_name text, last_name text, id_town integer, id_township integer, id_street integer, exterior_number text, contacts eureka_public.contact[], username text, role text, id integer, password text) OWNER TO eureka_administrador;

--
-- Name: modify_role(text, text, eureka_public.role_privileges[]); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_role(role_name text, prev_role_name text, role_privileges eureka_public.role_privileges[]) RETURNS eureka_public.selected_role
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        privileges eureka_public.role_privileges;
        privileges_module eureka_public.privileges_module;
        privileges_role eureka_public.privileges_module[];
        selected_role eureka_public.selected_role;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE pg_roles.rolname LIKE 'eureka_' || LOWER($1)) THEN
            EXECUTE 'ALTER ROLE ' || 'eureka_' || LOWER($2) || ' RENAME TO ' || 'eureka_' || LOWER($1) || ';';
        END IF;

        FOREACH privileges IN ARRAY $3 LOOP
            IF privileges.module = 'Clients' THEN
                IF privileges.add_modify THEN
                    EXECUTE
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client_contact FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.client_contract FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.business_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;

                IF privileges.delete THEN
                    EXECUTE
                        'GRANT DELETE ON TABLE eureka_public.client TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.client_contact TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.client_contract TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.business_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE DELETE ON TABLE eureka_public.client FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.client_contact FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.client_contract FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.business_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;
            ELSEIF privileges.module = 'Employees' THEN
                IF privileges.add_modify THEN
                    EXECUTE
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT INSERT, UPDATE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.employee FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE INSERT, UPDATE ON TABLE eureka_public.employee_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;

                IF privileges.delete THEN
                    EXECUTE
                        'GRANT DELETE ON TABLE eureka_public.employee TO ' || 'eureka_' || LOWER($1) || ';' ||
                        'GRANT DELETE ON TABLE eureka_public.employee_contact TO ' || 'eureka_' || LOWER($1) || ';';
                ELSE
                    EXECUTE
                        'REVOKE DELETE ON TABLE eureka_public.employee FROM ' || 'eureka_' || LOWER($1) || ';' ||
                        'REVOKE DELETE ON TABLE eureka_public.employee_contact FROM ' || 'eureka_' || LOWER($1) || ';';
                END IF;
            END IF;
        END LOOP;

        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || 'eureka_' || LOWER($1) || '%')
            GROUP BY
                table_name
        LOOP
            privileges_role := ARRAY_APPEND(privileges_role, privileges_module);
        END LOOP;

        selected_role := ($1, privileges_role);

        RETURN selected_role;
    END;
$_$;


ALTER FUNCTION eureka_public.modify_role(role_name text, prev_role_name text, role_privileges eureka_public.role_privileges[]) OWNER TO eureka_administrador;

--
-- Name: modify_street(text, integer, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_street(street text, id_township integer, id integer) RETURNS eureka_public.street
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.street
    SET
        street = $1,
        id_township = $2
    WHERE
        id = $3
    RETURNING
        *;
$_$;


ALTER FUNCTION eureka_public.modify_street(street text, id_township integer, id integer) OWNER TO eureka_administrador;

--
-- Name: modify_town(integer, text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_town(id integer, town text) RETURNS eureka_public.town
    LANGUAGE sql STRICT
    AS $_$
    UPDATE eureka_public.town SET town = $2 WHERE id = $1 RETURNING *;
$_$;


ALTER FUNCTION eureka_public.modify_town(id integer, town text) OWNER TO eureka_administrador;

--
-- Name: modify_township(text, text, text, integer, integer); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.modify_township(type_township text, township text, postal_code text, id_town integer, id integer) RETURNS eureka_public.township
    LANGUAGE sql STRICT
    AS $_$
    UPDATE
        eureka_public.township
    SET
        type_township = $1,
        township = $2,
        postal_code = $3,
        id_town = $4
    WHERE
        id = $5
    RETURNING
        *;
$_$;


ALTER FUNCTION eureka_public.modify_township(type_township text, township text, postal_code text, id_town integer, id integer) OWNER TO eureka_administrador;

--
-- Name: pay_and_renovate_client_contract(integer, text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.pay_and_renovate_client_contract(id_contract integer, type_contract text) RETURNS eureka_public.client_contract
    LANGUAGE plpgsql STRICT
    AS $_$
    DECLARE
        renovated_client_contract eureka_public.client_contract;
        translated_type_contract TEXT;
    BEGIN
        IF $2 = '1 MES' THEN
            translated_type_contract = REPLACE($2, 'MES', 'MONTH');
        ELSE
            translated_type_contract = REPLACE($2, 'MESES', 'MONTHS');
        END IF;

        UPDATE
            eureka_public.client_contract
        SET
            type_contract = $2,
            start_date = NOW(),
            end_date = NOW() + translated_type_contract::INTERVAL,
            status = 'Activo'
        WHERE
            id = $1
        RETURNING * INTO 
            renovated_client_contract;

        IF $2 = '1 MES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );
        ELSEIF $2 = '2 MESES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 1 MONTH'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );
        ELSEIF $2 = '3 MESES' THEN
            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date,
                'Pagado',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 1 MONTH'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );

            INSERT INTO eureka_public.client_contract_movement(
                date,
                movement,
                id_contract
            ) VALUES(
                renovated_client_contract.start_date + '3 DAYS 2 MONTHS'::INTERVAL,
                'Por Pagar',
                renovated_client_contract.id
            );
        END IF;

        RETURN renovated_client_contract;
    END;
$_$;


ALTER FUNCTION eureka_public.pay_and_renovate_client_contract(id_contract integer, type_contract text) OWNER TO eureka_administrador;

--
-- Name: role_by_name(text); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.role_by_name(role_name text) RETURNS eureka_public.selected_role
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
    DECLARE
        privileges_module eureka_public.privileges_module;
        privileges_role eureka_public.privileges_module[];
        selected_role eureka_public.selected_role;
    BEGIN
        FOR privileges_module IN
            SELECT
                table_name,
                string_agg(privilege_type, ', ')
            FROM
                information_schema.role_table_grants
            WHERE
                grantee
            ILIKE
                ('%' || $1 || '%')
            GROUP BY
                table_name
        LOOP
            privileges_role := ARRAY_APPEND(privileges_role, privileges_module);
        END LOOP;

        selected_role := ($1, privileges_role);

        RETURN selected_role;
    END;
$_$;


ALTER FUNCTION eureka_public.role_by_name(role_name text) OWNER TO eureka_administrador;

--
-- Name: update_contracts_status(); Type: FUNCTION; Schema: eureka_public; Owner: eureka_administrador
--

CREATE FUNCTION eureka_public.update_contracts_status() RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
        contract eureka_public.client_contract;
        contract_movement eureka_public.client_contract_movement;
    BEGIN
        FOR contract IN
            SELECT * FROM eureka_public.client_contract WHERE TO_CHAR(end_date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY')
        LOOP
            IF NOT EXISTS(SELECT * FROM eureka_public.client_contract_movement WHERE date BETWEEN contract.start_date AND contract.end_date AND movement LIKE 'Adeudo') THEN
                UPDATE eureka_public.client_contract SET status = 'Finalizado' WHERE id = contract.id;
            END IF;
        END LOOP;

        FOR contract_movement IN
            SELECT * FROM eureka_public.client_contract_movement WHERE TO_CHAR(date, 'MM-YYYY') = TO_CHAR(NOW(), 'MM-YYYY')
        LOOP
            IF TO_CHAR(contract_movement.date, 'DD-MM-YYYY') = TO_CHAR(NOW(), 'DD-MM-YYYY') AND contract_movement.movement LIKE 'Por Pagar' THEN
                UPDATE eureka_public.client_contract SET status = 'Por Pagar' WHERE id = contract_movement.id_contract;
            ELSEIF TO_CHAR(contract_movement.date, 'DD-MM-YYYY') < TO_CHAR(NOW(), 'DD-MM-YYYY') AND contract_movement.movement LIKE 'Por Pagar' THEN
                UPDATE eureka_public.client_contract SET status = 'Adeudo' WHERE id = contract_movement.id_contract;
                UPDATE eureka_public.client_contract_movement SET movement = 'Adeudo' WHERE movement LIKE 'Por Pagar' AND id_contract = contract_movement.id_contract;
            END IF;
        END LOOP;

        RETURN;
    END;
$$;


ALTER FUNCTION eureka_public.update_contracts_status() OWNER TO eureka_administrador;

--
-- Name: notify_watchers_ddl(); Type: FUNCTION; Schema: postgraphile_watch; Owner: eureka_administrador
--

CREATE FUNCTION postgraphile_watch.notify_watchers_ddl() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'ddl',
      'payload',
      (select json_agg(json_build_object('schema', schema_name, 'command', command_tag)) from pg_event_trigger_ddl_commands() as x)
    )::text
  );
end;
$$;


ALTER FUNCTION postgraphile_watch.notify_watchers_ddl() OWNER TO eureka_administrador;

--
-- Name: notify_watchers_drop(); Type: FUNCTION; Schema: postgraphile_watch; Owner: eureka_administrador
--

CREATE FUNCTION postgraphile_watch.notify_watchers_drop() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'drop',
      'payload',
      (select json_agg(distinct x.schema_name) from pg_event_trigger_dropped_objects() as x)
    )::text
  );
end;
$$;


ALTER FUNCTION postgraphile_watch.notify_watchers_drop() OWNER TO eureka_administrador;

--
-- Name: employee_user_password; Type: TABLE; Schema: eureka_private; Owner: eureka_administrador
--

CREATE TABLE eureka_private.employee_user_password (
    password_hash text NOT NULL,
    id_employee_user integer NOT NULL
);


ALTER TABLE eureka_private.employee_user_password OWNER TO eureka_administrador;

--
-- Name: business_contact; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.business_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_contract integer NOT NULL
);


ALTER TABLE eureka_public.business_contact OWNER TO eureka_administrador;

--
-- Name: TABLE business_contact; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.business_contact IS '@omit all';


--
-- Name: client_contact; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.client_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_client integer NOT NULL
);


ALTER TABLE eureka_public.client_contact OWNER TO eureka_administrador;

--
-- Name: TABLE client_contact; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.client_contact IS '@omit all';


--
-- Name: client_contract_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.client_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.client_contract_id_seq OWNER TO eureka_administrador;

--
-- Name: client_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.client_contract_id_seq OWNED BY eureka_public.client_contract.id;


--
-- Name: client_contract_type_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.client_contract_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.client_contract_type_id_seq OWNER TO eureka_administrador;

--
-- Name: client_contract_type_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.client_contract_type_id_seq OWNED BY eureka_public.client_contract_type.id;


--
-- Name: client_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.client_id_seq OWNER TO eureka_administrador;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.client_id_seq OWNED BY eureka_public.client.id;


--
-- Name: employee_contact; Type: TABLE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE TABLE eureka_public.employee_contact (
    type_contact text NOT NULL,
    contact text NOT NULL,
    id_employee integer NOT NULL
);


ALTER TABLE eureka_public.employee_contact OWNER TO eureka_administrador;

--
-- Name: TABLE employee_contact; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON TABLE eureka_public.employee_contact IS '@omit all';


--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.employee_id_seq OWNER TO eureka_administrador;

--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.employee_id_seq OWNED BY eureka_public.employee.id;


--
-- Name: employee_user_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.employee_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.employee_user_id_seq OWNER TO eureka_administrador;

--
-- Name: employee_user_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.employee_user_id_seq OWNED BY eureka_public.employee_user.id;


--
-- Name: street_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.street_id_seq OWNER TO eureka_administrador;

--
-- Name: street_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.street_id_seq OWNED BY eureka_public.street.id;


--
-- Name: town_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.town_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.town_id_seq OWNER TO eureka_administrador;

--
-- Name: town_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.town_id_seq OWNED BY eureka_public.town.id;


--
-- Name: township_id_seq; Type: SEQUENCE; Schema: eureka_public; Owner: eureka_administrador
--

CREATE SEQUENCE eureka_public.township_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eureka_public.township_id_seq OWNER TO eureka_administrador;

--
-- Name: township_id_seq; Type: SEQUENCE OWNED BY; Schema: eureka_public; Owner: eureka_administrador
--

ALTER SEQUENCE eureka_public.township_id_seq OWNED BY eureka_public.township.id;


--
-- Name: client id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_id_seq'::regclass);


--
-- Name: client_contract id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_contract_id_seq'::regclass);


--
-- Name: client_contract_type id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract_type ALTER COLUMN id SET DEFAULT nextval('eureka_public.client_contract_type_id_seq'::regclass);


--
-- Name: employee id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee ALTER COLUMN id SET DEFAULT nextval('eureka_public.employee_id_seq'::regclass);


--
-- Name: employee_user id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_user ALTER COLUMN id SET DEFAULT nextval('eureka_public.employee_user_id_seq'::regclass);


--
-- Name: street id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.street ALTER COLUMN id SET DEFAULT nextval('eureka_public.street_id_seq'::regclass);


--
-- Name: town id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.town ALTER COLUMN id SET DEFAULT nextval('eureka_public.town_id_seq'::regclass);


--
-- Name: township id; Type: DEFAULT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.township ALTER COLUMN id SET DEFAULT nextval('eureka_public.township_id_seq'::regclass);


--
-- Data for Name: employee_user_password; Type: TABLE DATA; Schema: eureka_private; Owner: eureka_administrador
--

COPY eureka_private.employee_user_password (password_hash, id_employee_user) FROM stdin;
\.
COPY eureka_private.employee_user_password (password_hash, id_employee_user) FROM '$$PATH$$/2458.dat';

--
-- Data for Name: business_contact; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.business_contact (type_contact, contact, id_contract) FROM stdin;
\.
COPY eureka_public.business_contact (type_contact, contact, id_contract) FROM '$$PATH$$/2466.dat';

--
-- Data for Name: client; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.client (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM stdin;
\.
COPY eureka_public.client (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM '$$PATH$$/2460.dat';

--
-- Data for Name: client_contact; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.client_contact (type_contact, contact, id_client) FROM stdin;
\.
COPY eureka_public.client_contact (type_contact, contact, id_client) FROM '$$PATH$$/2461.dat';

--
-- Data for Name: client_contract; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.client_contract (id, business, id_town, id_township, id_street, exterior_number, id_type_contract, start_date, end_date, status, id_client) FROM stdin;
\.
COPY eureka_public.client_contract (id, business, id_town, id_township, id_street, exterior_number, id_type_contract, start_date, end_date, status, id_client) FROM '$$PATH$$/2465.dat';

--
-- Data for Name: client_contract_movement; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.client_contract_movement (date, movement, id_contract) FROM stdin;
\.
COPY eureka_public.client_contract_movement (date, movement, id_contract) FROM '$$PATH$$/2467.dat';

--
-- Data for Name: client_contract_type; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.client_contract_type (id, type_name, number_months, month_price, tax_type, tax_percentage, discount_percentage) FROM stdin;
\.
COPY eureka_public.client_contract_type (id, type_name, number_months, month_price, tax_type, tax_percentage, discount_percentage) FROM '$$PATH$$/2463.dat';

--
-- Data for Name: employee; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.employee (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM stdin;
\.
COPY eureka_public.employee (id, name, first_name, last_name, id_town, id_township, id_street, exterior_number, created_at) FROM '$$PATH$$/2454.dat';

--
-- Data for Name: employee_contact; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.employee_contact (type_contact, contact, id_employee) FROM stdin;
\.
COPY eureka_public.employee_contact (type_contact, contact, id_employee) FROM '$$PATH$$/2455.dat';

--
-- Data for Name: employee_user; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.employee_user (id, username, role, id_employee) FROM stdin;
\.
COPY eureka_public.employee_user (id, username, role, id_employee) FROM '$$PATH$$/2457.dat';

--
-- Data for Name: street; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.street (id, street, id_township) FROM stdin;
\.
COPY eureka_public.street (id, street, id_township) FROM '$$PATH$$/2452.dat';

--
-- Data for Name: town; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.town (id, town) FROM stdin;
\.
COPY eureka_public.town (id, town) FROM '$$PATH$$/2448.dat';

--
-- Data for Name: township; Type: TABLE DATA; Schema: eureka_public; Owner: eureka_administrador
--

COPY eureka_public.township (id, type_township, township, postal_code, id_town) FROM stdin;
\.
COPY eureka_public.township (id, type_township, township, postal_code, id_town) FROM '$$PATH$$/2450.dat';

--
-- Name: client_contract_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.client_contract_id_seq', 1, true);


--
-- Name: client_contract_type_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.client_contract_type_id_seq', 2, true);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.client_id_seq', 1, true);


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.employee_id_seq', 2, true);


--
-- Name: employee_user_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.employee_user_id_seq', 2, true);


--
-- Name: street_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.street_id_seq', 3, true);


--
-- Name: town_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.town_id_seq', 3, true);


--
-- Name: township_id_seq; Type: SEQUENCE SET; Schema: eureka_public; Owner: eureka_administrador
--

SELECT pg_catalog.setval('eureka_public.township_id_seq', 3, true);


--
-- Name: employee_user_password employee_user_password_id_employee_user_key; Type: CONSTRAINT; Schema: eureka_private; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_private.employee_user_password
    ADD CONSTRAINT employee_user_password_id_employee_user_key UNIQUE (id_employee_user);


--
-- Name: client_contract client_contract_business_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_business_key UNIQUE (business);


--
-- Name: CONSTRAINT client_contract_business_key ON client_contract; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT client_contract_business_key ON eureka_public.client_contract IS '@omit';


--
-- Name: client_contract client_contract_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_pkey PRIMARY KEY (id);


--
-- Name: client_contract_type client_contract_type_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract_type
    ADD CONSTRAINT client_contract_type_pkey PRIMARY KEY (id);


--
-- Name: client_contract_type client_contract_type_type_name_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract_type
    ADD CONSTRAINT client_contract_type_type_name_key UNIQUE (type_name);


--
-- Name: CONSTRAINT client_contract_type_type_name_key ON client_contract_type; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT client_contract_type_type_name_key ON eureka_public.client_contract_type IS '@omit';


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: CONSTRAINT employee_pkey ON employee; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT employee_pkey ON eureka_public.employee IS '@omit';


--
-- Name: employee_user employee_user_id_employee_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_id_employee_key UNIQUE (id_employee);


--
-- Name: CONSTRAINT employee_user_id_employee_key ON employee_user; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT employee_user_id_employee_key ON eureka_public.employee_user IS '@omit';


--
-- Name: employee_user employee_user_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_pkey PRIMARY KEY (id);


--
-- Name: CONSTRAINT employee_user_pkey ON employee_user; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT employee_user_pkey ON eureka_public.employee_user IS '@omit';


--
-- Name: employee_user employee_user_username_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_username_key UNIQUE (username);


--
-- Name: CONSTRAINT employee_user_username_key ON employee_user; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT employee_user_username_key ON eureka_public.employee_user IS '@omit';


--
-- Name: street street_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.street
    ADD CONSTRAINT street_pkey PRIMARY KEY (id);


--
-- Name: town town_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.town
    ADD CONSTRAINT town_pkey PRIMARY KEY (id);


--
-- Name: town town_town_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.town
    ADD CONSTRAINT town_town_key UNIQUE (town);


--
-- Name: CONSTRAINT town_town_key ON town; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT town_town_key ON eureka_public.town IS '@omit';


--
-- Name: township township_pkey; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_pkey PRIMARY KEY (id);


--
-- Name: township township_postal_code_key; Type: CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_postal_code_key UNIQUE (postal_code);


--
-- Name: CONSTRAINT township_postal_code_key ON township; Type: COMMENT; Schema: eureka_public; Owner: eureka_administrador
--

COMMENT ON CONSTRAINT township_postal_code_key ON eureka_public.township IS '@omit';


--
-- Name: employee_user_password_id_employee_user_idx; Type: INDEX; Schema: eureka_private; Owner: eureka_administrador
--

CREATE INDEX employee_user_password_id_employee_user_idx ON eureka_private.employee_user_password USING btree (id_employee_user);


--
-- Name: business_contact_id_contract_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX business_contact_id_contract_idx ON eureka_public.business_contact USING btree (id_contract);


--
-- Name: client_contact_id_client_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contact_id_client_idx ON eureka_public.client_contact USING btree (id_client);


--
-- Name: client_contract_end_date_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_end_date_idx ON eureka_public.client_contract USING btree (eureka_public.custom_to_char_client_contract_end_date(end_date));


--
-- Name: client_contract_id_client_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_id_client_idx ON eureka_public.client_contract USING btree (id_client);


--
-- Name: client_contract_id_street_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_id_street_idx ON eureka_public.client_contract USING btree (id_street);


--
-- Name: client_contract_id_town_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_id_town_idx ON eureka_public.client_contract USING btree (id_town);


--
-- Name: client_contract_id_township_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_id_township_idx ON eureka_public.client_contract USING btree (id_township);


--
-- Name: client_contract_id_type_contract_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_id_type_contract_idx ON eureka_public.client_contract USING btree (id_type_contract);


--
-- Name: client_contract_movement_id_contract_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_movement_id_contract_idx ON eureka_public.client_contract_movement USING btree (id_contract);


--
-- Name: client_contract_movement_movement_date_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_movement_movement_date_idx ON eureka_public.client_contract_movement USING btree (eureka_public.custom_to_char_client_contract_movement_date(date));


--
-- Name: client_contract_movement_movement_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_contract_movement_movement_idx ON eureka_public.client_contract_movement USING btree (movement);


--
-- Name: client_id_street_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_id_street_idx ON eureka_public.client USING btree (id_street);


--
-- Name: client_id_town_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_id_town_idx ON eureka_public.client USING btree (id_town);


--
-- Name: client_id_township_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX client_id_township_idx ON eureka_public.client USING btree (id_township);


--
-- Name: employee_contact_id_employee_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX employee_contact_id_employee_idx ON eureka_public.employee_contact USING btree (id_employee);


--
-- Name: employee_id_street_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX employee_id_street_idx ON eureka_public.employee USING btree (id_street);


--
-- Name: employee_id_town_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX employee_id_town_idx ON eureka_public.employee USING btree (id_town);


--
-- Name: employee_id_township_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX employee_id_township_idx ON eureka_public.employee USING btree (id_township);


--
-- Name: employee_user_id_employee_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX employee_user_id_employee_idx ON eureka_public.employee_user USING btree (id_employee);


--
-- Name: street_id_township_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX street_id_township_idx ON eureka_public.street USING btree (id_township);


--
-- Name: township_id_town_idx; Type: INDEX; Schema: eureka_public; Owner: eureka_administrador
--

CREATE INDEX township_id_town_idx ON eureka_public.township USING btree (id_town);


--
-- Name: employee_user_password employee_user_password_id_employee_user_fkey; Type: FK CONSTRAINT; Schema: eureka_private; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_private.employee_user_password
    ADD CONSTRAINT employee_user_password_id_employee_user_fkey FOREIGN KEY (id_employee_user) REFERENCES eureka_public.employee_user(id) ON DELETE CASCADE;


--
-- Name: business_contact business_contact_id_contract_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.business_contact
    ADD CONSTRAINT business_contact_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES eureka_public.client_contract(id) ON DELETE CASCADE;


--
-- Name: client_contact client_contact_id_client_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contact
    ADD CONSTRAINT client_contact_id_client_fkey FOREIGN KEY (id_client) REFERENCES eureka_public.client(id) ON DELETE CASCADE;


--
-- Name: client_contract client_contract_id_client_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_client_fkey FOREIGN KEY (id_client) REFERENCES eureka_public.client(id) ON DELETE CASCADE;


--
-- Name: client_contract client_contract_id_street_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);


--
-- Name: client_contract client_contract_id_town_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);


--
-- Name: client_contract client_contract_id_township_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);


--
-- Name: client_contract client_contract_id_type_contract_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract
    ADD CONSTRAINT client_contract_id_type_contract_fkey FOREIGN KEY (id_type_contract) REFERENCES eureka_public.client_contract_type(id) ON DELETE CASCADE;


--
-- Name: client_contract_movement client_contract_movement_id_contract_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client_contract_movement
    ADD CONSTRAINT client_contract_movement_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES eureka_public.client_contract(id) ON DELETE CASCADE;


--
-- Name: client client_id_street_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);


--
-- Name: client client_id_town_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);


--
-- Name: client client_id_township_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.client
    ADD CONSTRAINT client_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);


--
-- Name: employee_contact employee_contact_id_employee_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_contact
    ADD CONSTRAINT employee_contact_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES eureka_public.employee(id) ON DELETE CASCADE;


--
-- Name: employee employee_id_street_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_street_fkey FOREIGN KEY (id_street) REFERENCES eureka_public.street(id);


--
-- Name: employee employee_id_town_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id);


--
-- Name: employee employee_id_township_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee
    ADD CONSTRAINT employee_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id);


--
-- Name: employee_user employee_user_id_employee_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.employee_user
    ADD CONSTRAINT employee_user_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES eureka_public.employee(id) ON DELETE CASCADE;


--
-- Name: street street_id_township_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.street
    ADD CONSTRAINT street_id_township_fkey FOREIGN KEY (id_township) REFERENCES eureka_public.township(id) ON DELETE CASCADE;


--
-- Name: township township_id_town_fkey; Type: FK CONSTRAINT; Schema: eureka_public; Owner: eureka_administrador
--

ALTER TABLE ONLY eureka_public.township
    ADD CONSTRAINT township_id_town_fkey FOREIGN KEY (id_town) REFERENCES eureka_public.town(id) ON DELETE CASCADE;


--
-- Name: postgraphile_watch_ddl; Type: EVENT TRIGGER; Schema: -; Owner: eureka_administrador
--

CREATE EVENT TRIGGER postgraphile_watch_ddl ON ddl_command_end
         WHEN TAG IN ('ALTER AGGREGATE', 'ALTER DOMAIN', 'ALTER EXTENSION', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER POLICY', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE AGGREGATE', 'CREATE DOMAIN', 'CREATE EXTENSION', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE INDEX', 'CREATE POLICY', 'CREATE RULE', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP AGGREGATE', 'DROP DOMAIN', 'DROP EXTENSION', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP INDEX', 'DROP OWNED', 'DROP POLICY', 'DROP RULE', 'DROP SCHEMA', 'DROP TABLE', 'DROP TYPE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE PROCEDURE postgraphile_watch.notify_watchers_ddl();


ALTER EVENT TRIGGER postgraphile_watch_ddl OWNER TO eureka_administrador;

--
-- Name: postgraphile_watch_drop; Type: EVENT TRIGGER; Schema: -; Owner: eureka_administrador
--

CREATE EVENT TRIGGER postgraphile_watch_drop ON sql_drop
   EXECUTE PROCEDURE postgraphile_watch.notify_watchers_drop();


ALTER EVENT TRIGGER postgraphile_watch_drop OWNER TO eureka_administrador;

--
-- Name: DATABASE eureka; Type: ACL; Schema: -; Owner: eureka_administrador
--

REVOKE CONNECT,TEMPORARY ON DATABASE eureka FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               