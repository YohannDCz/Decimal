INSERT INTO pics (publication_id, url, content, tags) VALUES
(22, NULL, 'Captured moments.', '["entertainment", "entertainment", "tech", "tech"]'),
(7, NULL, 'Sunkissed.', '["education", "tech", "education", "tech", "lifestyle"]'),
(47, NULL, 'Weekend vibes.', '["music", "tech"]'),
(57, NULL, 'Go where you feel most alive.', '["tech", "music"]'),
(46, NULL, 'Smell the sea, feel the sky.', '["music", "tech", "lifestyle"]'),
(39, NULL, 'Life is better when you’re laughing.', '["music", "entertainment"]'),
(38, NULL, 'And so the adventure begins.', '["education", "music", "lifestyle"]'),
(18, NULL, 'Get out there.', '["music", "education"]'),
(10, NULL, 'Chasing sunsets.', '["entertainment", "lifestyle", "music", "tech"]'),
(24, NULL, 'All about that wanderlust.', '["education", "music", "music", "education", "entertainment"]'),
(25, NULL, 'Keeping it simple.', '["music", "education", "education"]'),
(38, NULL, 'Stay golden.', '["music", "tech", "tech", "entertainment"]'),
(39, NULL, 'Lost and found.', '["education", "education", "entertainment", "lifestyle"]'),
(16, NULL, 'Making memories.', '["entertainment", "entertainment"]'),
(11, NULL, 'Be yourself.', '["education", "education", "tech"]'),
(14, NULL, 'Life is better when you’re laughing.', '["education", "education", "education", "education", "entertainment"]'),
(50, NULL, 'The best is yet to come.', '["music", "entertainment"]'),
(39, NULL, 'Never stop exploring.', '["education", "music", "tech", "entertainment", "entertainment"]'),
(16, NULL, 'Keeping it simple.', '["lifestyle", "lifestyle", "lifestyle", "music", "education"]'),
(12, NULL, 'Captured moments.', '["education", "lifestyle"]'),
(36, NULL, 'Good times and tan lines.', '["music", "music"]'),
(27, NULL, 'Happiness is not a destination, it''s a way of life.', '["music", "entertainment", "lifestyle"]'),
(32, NULL, 'Just breathe.', '["lifestyle", "entertainment", "tech", "entertainment"]'),
(54, NULL, 'Hakuna Matata.', '["entertainment", "tech"]'),
(40, NULL, 'And so the adventure begins.', '["tech", "tech", "tech"]'),
(16, NULL, 'Sunkissed.', '["entertainment", "music", "music", "lifestyle"]'),
(58, NULL, 'Good times and tan lines.', '["entertainment", "education", "entertainment"]'),
(7, NULL, 'Do more things that make you forget to check your phone.', '["entertainment", "tech", "education", "lifestyle", "tech"]'),
(4, NULL, 'Happiness is not a destination, it''s a way of life.', '["entertainment", "entertainment", "education", "education", "lifestyle"]'),
(19, NULL, 'Hakuna Matata.', '["tech", "entertainment", "tech"]'),
(7, NULL, 'And so the adventure begins.', '["education", "education", "education", "lifestyle", "tech"]'),
(25, NULL, 'Collect moments, not things.', '["music", "entertainment", "education"]'),
(10, NULL, 'Dream big, little one.', '["education", "education", "tech", "lifestyle", "tech"]'),
(17, NULL, 'Keeping it simple.', '["lifestyle", "education", "education", "music", "tech"]'),
(4, NULL, 'Good times and tan lines.', '["lifestyle", "education", "education", "music", "entertainment"]'),
(33, NULL, 'Dare to dream.', '["education", "education", "tech", "lifestyle", "tech"]'),
(12, NULL, 'Smell the sea, feel the sky.', '["lifestyle", "music", "lifestyle", "music", "entertainment"]'),
(55, NULL, 'The simple things.', '["entertainment", "education"]'),
(29, NULL, 'Dare to live the life you’ve always wanted.', '["education", "lifestyle", "education"]'),
(42, NULL, 'Good times and tan lines.', '["lifestyle", "education", "tech", "education", "education"]'),
(8, NULL, 'Go where you feel most alive.', '["entertainment", "tech", "lifestyle"]'),
(25, NULL, 'You did not wake up today to be mediocre.', '["entertainment", "entertainment", "entertainment", "education"]'),
(17, NULL, 'Do more things that make you forget to check your phone.', '["lifestyle", "education", "tech", "music"]'),
(33, NULL, 'Your vibe attracts your tribe.', '["music", "tech", "music", "music", "music"]'),
(10, NULL, 'Hakuna Matata.', '["lifestyle", "entertainment", "entertainment", "lifestyle", "music"]'),
(34, NULL, 'Be happy, it drives people crazy.', '["lifestyle", "tech", "tech", "entertainment"]'),
(8, NULL, 'Just go.', '["tech", "education"]'),
(56, NULL, 'Living for these vibes.', '["tech", "tech", "tech", "music", "music"]'),
(33, NULL, 'Never stop exploring.', '["tech", "tech", "music"]'),
(2, NULL, 'Life''s a journey.', '["education", "tech", "music"]'),
(3, NULL, 'Living the dream.', '["music", "tech", "education"]'),
(45, NULL, 'Lost and found.', '["education", "entertainment", "music"]'),
(4, NULL, 'Let the good times roll.', '["education", "lifestyle", "lifestyle", "lifestyle"]'),
(5, NULL, 'The simple things.', '["tech", "music", "music"]'),
(33, NULL, 'The best is yet to come.', '["entertainment", "lifestyle", "tech", "tech"]'),
(15, NULL, 'Go where you feel most alive.', '["entertainment", "education"]'),
(60, NULL, 'Stay golden.', '["entertainment", "entertainment", "entertainment", "music", "music"]'),
(44, NULL, 'Another day, another adventure.', '["lifestyle", "music", "education"]'),
(50, NULL, 'Wherever you go, go with all your heart.', '["lifestyle", "music", "tech", "tech"]'),
(9, NULL, 'Just breathe.', '["lifestyle", "entertainment", "tech", "entertainment"]'),
(45, NULL, 'Dare to live the life you’ve always wanted.', '["music", "education", "education", "lifestyle", "education"]'),
(29, NULL, 'Dream. Plan. Do.', '["tech", "tech", "lifestyle", "tech", "music"]'),
(28, NULL, 'And so the adventure begins.', '["lifestyle", "education", "entertainment"]'),
(22, NULL, 'Good times and tan lines.', '["music", "education", "tech", "tech"]'),
(35, NULL, 'Chasing sunsets.', '["tech", "tech"]'),
(28, NULL, 'Life''s a journey.', '["tech", "tech", "entertainment", "entertainment"]'),
(19, NULL, 'Better together.', '["music", "lifestyle", "education", "music"]'),
(55, NULL, 'Life in color.', '["music", "entertainment"]');

WITH RankedPublications AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rn
    FROM publications
    WHERE type = 'post'
),
RankedPics AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rn
    FROM pics
)
UPDATE pics
SET publication_id = RankedPublications.id
FROM RankedPics
JOIN RankedPublications ON RankedPics.rn = RankedPublications.rn
WHERE pics.id = RankedPics.id;
