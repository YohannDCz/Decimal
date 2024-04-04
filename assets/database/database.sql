CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) UNIQUE NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "date_of_birth" DATE NOT NULL,
  "sex" VARCHAR(255) NOT NULL,
  "city" VARCHAR(255) NOT NULL,
  "country" VARCHAR(255) NOT NULL,
  "biography" TEXT NOT NULL,
  "profile_photo" VARCHAR(255) NOT NULL,
  "cover_photo" VARCHAR(255) NOT NULL,
  "date_of_registration" TIMESTAMPTZ NOT NULL,
  "language" VARCHAR(255) NOT NULL,
  "timezone" VARCHAR(255) NOT NULL,
  "last_seen" TIMESTAMPTZ NOT NULL,
  "is_online" BOOLEAN NOT NULL,
  "is_verified" BOOLEAN NOT NULL,
  "uuid" VARCHAR(255) NOT NULL,
  "pseudo" VARCHAR(255) NOT NULL,

);

CREATE TABLE "subscriptions" (
  "user_id_1" INT NOT NULL,
  "user_id_2" INT NOT NULL,
  PRIMARY KEY ("user_id_1", "user_id_2")
);

CREATE TABLE "likes" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "user_id" INT NOT NULL
  "date_of_like" TIMESTAMPTZ NOT NULL

);

CREATE TABLE "loves" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "user_id" INT NOT NULL
  "date_of_love" TIMESTAMPTZ NOT NULL

);

CREATE TABLE "comments" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "user_id" INT NOT NULL,
  "content" TEXT NOT NULL,
  "date_of_comment" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "reposts" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL,
  "shared_on" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "publications" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INT NOT NULL,
  "type" VARCHAR(255) NOT NULL,
  "date_of_publication" TIMESTAMPTZ NOT NULL,
  "location" VARCHAR(255) NOT NULL
);

CREATE TABLE "posts" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INTEGER NOT NULL,
  "url" TEXT NOT NULL,
  "content" TEXT,
  "tags" JSON NOT NULL

);

CREATE TABLE "articles" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INTEGER NOT NULL,
  "url" TEXT NOT NULL,
  "content" TEXT,
  "tags" JSON NOT NULL

);

CREATE TABLE "pics" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "tags" JSON NOT NULL
);

CREATE TABLE "pictures" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "board_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "tags" JSON NOT NULL
);

CREATE TABLE "vids" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "duration" INT NOT NULL,
  "tags" JSON NOT NULL
);

CREATE TABLE "videos" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "title" VARCHAR(255) NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "duration" INT NOT NULL,
  "tags" JSON NOT NULL
);

CREATE TABLE "songs" (
  "id" SERIAL PRIMARY KEY,
  "publication_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "tags" JSON NOT NULL
);

CREATE TABLE "stories" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INT NOT NULL,
  "publication_id" INT NOT NULL,
  "url" TEXT NOT NULL,
  "title" VARCHAR(255) NOT NULL,
  "content" VARCHAR(255) NOT NULL,
  "tags" JSON NOT NULL,
);

CREATE TABLE "boards" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "description" TEXT NOT NULL,
  "user_id" INT NOT NULL,
  "members" JSON NOT NULL,
  "pictures" JSON NOT NULL,
  "date_of_publication" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "subscriptions" (
  "user_id_1" INT NOT NULL,
  "user_id_2" INT NOT NULL,
  PRIMARY KEY ("user_id_1", "user_id_2")
);

CREATE TABLE "subscriptions_board" (
  "board_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL,
  "added_on" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "contacts" (
  "user_id" INTEGER NOT NULL,
  "contact_id" INTEGER NOT NULL,
  "started_contact" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "followings" (
  "user_id" INTEGER NOT NULL,
  "following_id" INTEGER NOT NULL,
  "started_following_on" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "followers" (
  "user_id" INTEGER NOT NULL,
  "follower_id" INTEGER NOT NULL,
  "started_following_on" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "groups" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "description" TEXT,
  "group_picture" VARCHAR(255)
);

CREATE TABLE "group_members" (
  "group_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL
);

CREATE TABLE "messages" (
  "id" SERIAL PRIMARY KEY,
  "conversation_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL,
  "content" TEXT,
  "sent_on" TIMESTAMPTZ NOT NULL
);

CREATE TABLE "conversations" (
  "id" SERIAL PRIMARY KEY,
  "participants" TEXT NOT NULL
);

ALTER TABLE "publications" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("user_id_1") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("user_id_2") REFERENCES "users" ("id");

ALTER TABLE "subscriptions_board" ADD FOREIGN KEY ("board_id") REFERENCES "boards" ("id");

ALTER TABLE "subscriptions_board" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "contacts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "contacts" ADD FOREIGN KEY ("contact_id") REFERENCES "users" ("id");

ALTER TABLE "followings" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "followings" ADD FOREIGN KEY ("following_id") REFERENCES "users" ("id");

ALTER TABLE "followers" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "followers" ADD FOREIGN KEY ("follower_id") REFERENCES "users" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "boards" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "pictures" ADD FOREIGN KEY ("board_id") REFERENCES "boards" ("id");

ALTER TABLE "friends" ADD CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "friends" ADD CONSTRAINT "fk_friend_id" FOREIGN KEY ("friend_id") REFERENCES "users" ("id");

ALTER TABLE "reposts" ADD CONSTRAINT "fk_post_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "reposts" ADD CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "group_members" ADD CONSTRAINT "fk_group_id" FOREIGN KEY ("group_id") REFERENCES "groups" ("id");

ALTER TABLE "group_members" ADD CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD CONSTRAINT "fk_conversation_id" FOREIGN KEY ("conversation_id") REFERENCES "conversations" ("id");

ALTER TABLE "messages" ADD CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "posts" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "articles" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "videos" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "vids" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "pics" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "pictures" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "stories" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE "songs" ADD CONSTRAINT "fk_publication_id" FOREIGN KEY ("publication_id") REFERENCES "publications" ("id");

ALTER TABLE users ADD COLUMN uuid UUID DEFAULT uuid_generate_v4();

ALTER TABLE boards ADD COLUMN user_uuid UUID;
ALTER TABLE subscriptions_board ADD COLUMN user_uuid UUID;
ALTER TABLE publications ADD COLUMN user_uuid UUID;
ALTER TABLE contacts ADD COLUMN user_uuid UUID;
ALTER TABLE contacts ADD COLUMN contact_uuid UUID;
ALTER TABLE followers ADD COLUMN user_uuid UUID;
ALTER TABLE followers ADD COLUMN follower_uuid UUID;
ALTER TABLE followings ADD COLUMN user_uuid UUID;
ALTER TABLE followings ADD COLUMN following_uuid UUID;
ALTER TABLE comments ADD COLUMN user_uuid UUID;
ALTER TABLE likes ADD COLUMN user_uuid UUID;
ALTER TABLE loves ADD COLUMN user_uuid UUID;
ALTER TABLE reposts ADD COLUMN user_uuid UUID;

UPDATE boards
SET user_uuid = (SELECT uuid FROM users WHERE users.id = boards.user_id);

UPDATE subscriptions_board
SET user_uuid = (SELECT uuid FROM users WHERE users.id = subscriptions_board.user_id);

UPDATE publications
SET user_uuid = (SELECT uuid FROM users WHERE users.id = publications.user_id);

UPDATE contacts
SET user_uuid = (SELECT uuid FROM users WHERE users.id = contacts.user_id);

UPDATE contacts
SET contact_uuid = (SELECT uuid FROM users WHERE users.id = contacts.contact_id);

UPDATE followings
SET user_uuid = (SELECT uuid FROM users WHERE users.id = followings.user_id);

UPDATE followings
SET following_uuid = (SELECT uuid FROM users WHERE users.id = followings.following_id);

UPDATE followers
SET user_uuid = (SELECT uuid FROM users WHERE users.id = followers.user_id);

UPDATE followers
SET follower_uuid = (SELECT uuid FROM users WHERE users.id = followers.follower_id);

UPDATE comments
SET user_uuid = (SELECT uuid FROM users WHERE users.id = comments.user_id);

UPDATE likes
SET user_uuid = (SELECT uuid FROM users WHERE users.id = likes.user_id);

UPDATE loves
SET user_uuid = (SELECT uuid FROM users WHERE users.id = loves.user_id);

UPDATE reposts
SET user_uuid = (SELECT uuid FROM users WHERE users.id = reposts.user_id);

ALTER TABLE boards 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE subscriptions_board
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE publications
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE comments 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE likes 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE loves 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE reposts
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE contacts
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE contacts 
ADD FOREIGN KEY (contact_uuid) REFERENCES users(uuid);

ALTER TABLE followings 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE followings 
ADD FOREIGN KEY (following_uuid) REFERENCES users(uuid);

ALTER TABLE followers 
ADD FOREIGN KEY (user_uuid) REFERENCES users(uuid);

ALTER TABLE followers 
ADD FOREIGN KEY (follower_uuid) REFERENCES users(uuid);

ALTER TABLE boards DROP COLUMN user_id;
ALTER TABLE subscriptions_board DROP COLUMN user_id;
ALTER TABLE publications DROP COLUMN user_id;
ALTER TABLE contacts DROP COLUMN user_id;
ALTER TABLE contacts DROP COLUMN contact_id;
ALTER TABLE followings DROP COLUMN user_id;
ALTER TABLE followings DROP COLUMN following_id;
ALTER TABLE followers DROP COLUMN user_id;
ALTER TABLE followers DROP COLUMN follower_id;
ALTER TABLE comments DROP COLUMN user_id;
ALTER TABLE likes DROP COLUMN user_id;
ALTER TABLE loves DROP COLUMN user_id;
ALTER TABLE reposts DROP COLUMN user_id;

