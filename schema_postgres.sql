-- Создание таблиц
CREATE TABLE IF NOT EXISTS quests (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS steps (
    id SERIAL PRIMARY KEY,
    quest_id INTEGER NOT NULL REFERENCES quests(id) ON DELETE CASCADE,
    page_number INTEGER NOT NULL,
    content TEXT NOT NULL,
    is_final BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS choices (
    id SERIAL PRIMARY KEY,
    from_step_id INTEGER NOT NULL REFERENCES steps(id) ON DELETE CASCADE,
    to_step_id INTEGER NOT NULL REFERENCES steps(id) ON DELETE CASCADE,
    text VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(64) PRIMARY KEY,
    quest_id INTEGER NOT NULL REFERENCES quests(id) ON DELETE CASCADE,
    current_step_id INTEGER NOT NULL REFERENCES steps(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Вставка квестов
INSERT INTO quests (title, description) VALUES
('Кольб и дракон', 'Храбрый норд отправляется убить дракона, угрожающего деревне.'),
('Голос из подвала', 'Исследователь оккультного прибывает в заброшенный дом в Аркхэме...');

-- Шаги: Кольб и дракон
INSERT INTO steps (quest_id, page_number, content, is_final) VALUES
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 1, 'Кольб был храбрым нордом-воином. Как-то раз вождь приказал ему убить злого дракона, который угрожал деревне. «Иди через горный перевал, Кольб, — сказал вождь. — На той стороне ты найдёшь дракона».', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 2, 'Кольб взял свои любимые топор и щит и пошёл к горному перевалу. Там он увидел пещеру, где гулял ветер, ледяную пещеру и узкую тропинку.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 3, 'Кольб поднялся на каменистый холм. Он увидел внизу спящего дракона, а у дороги неподалёку он увидел таверну.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 4, 'Кольб шёл по запаху и наткнулся на грязного, вонючего орка! Орк зарычал и занес над героем свою шипастую дубину.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 5, 'Осторожно ступая по болоту, Кольб увидел, что путь ему преградил скорбно воющий призрак.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 6, 'Топор застрял в могучей чешуйчатой шее чудовища. Оно взвыло и забило хвостом, но Кольб не сдавался и в конце концов, орудуя топором как пилой, отделил голову дракона от тела. Кольб вернулся домой с победой, и его деревне драконы больше никогда не угрожали.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 7, 'Оставив болото позади, Кольб увидел неподалёку логово дракона, а также небольшую уютную таверну.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 8, 'Сильный порыв ветра загасил факел Кольба и столкнул его в яму. Кольб свернул шею и умер.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 9, 'Орк противно захихикал, когда его дубина расщепила щит Кольба и врезалась ему прямо в лицо. Кольб умер, и орк сварил себе похлёбку из его костей.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 10, 'Кольб вспомнил, что рассказывала ему бабушка, и протянул два золотых призраку. Тот растворился в воздухе, открыв Кольбу путь.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 11, 'Кольб начал подбираться к брюху чудовища, но как только он выпустил из виду голову дракона, тот распахнул пасть и проглотил Кольба целиком, прямо с топором и всем прочим.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 12, 'Поднявшись наверх, Кольб обнаружил лагерь. Там он встретил мудреца, который разделил с ним трапезу и показал два пути, ведущие в логово дракона. Первый вёл через холмы, а второй — через болото.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 13, 'Кольб широко размахнулся топором, и не успел орк ударить, его голова и дубина покатились по полу. Они ему больше не понадобятся.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 14, 'Кольб решил остановиться в таверне, чтобы отдохнуть перед боем с драконом. Но таверной управляли высокие эльфы, и они отравили его мёд, чтобы забрать его золото себе.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 15, 'Кольб замахнулся топором изо всей силы, но призрак этого будто бы даже не заметил. Он приблизился к Кольбу, и тот погрузился в глубокий сон и никогда больше не проснулся.', TRUE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 16, 'Кольб обнаружил логово, где спал дракон. Клубы дыма вырывались из его ноздрей, а воздух в пещере резал глаза. Кольб едва не поскользнулся на человеческих костях, на которых не оставалось ни кусочка мяса. Чудовище лежало на боку, открыв для удара брюхо и глотку.', FALSE),
((SELECT id FROM quests WHERE title = 'Кольб и дракон'), 17, 'Кольб вошёл в обледенелую пещеру, но он был нордом, поэтому не замёрз. Перед ним был тоннель, из которого чем-то воняло, а в тоннеле слева от него завывал ветер. И ещё рядом была лестница.', FALSE);

-- Шаги: Голос из подвала
INSERT INTO steps (quest_id, page_number, content, is_final) VALUES
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 1, 'Вы — исследователь оккультного, прибывший в заброшенный дом на окраине Аркхэма. Соседи шепчут, что прошлый владелец сошёл с ума, слушая «голос из подвала». Дверь в дом приоткрыта. Внутри пахнет плесенью и гнилью.', FALSE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 2, 'В холле — разбросанные книги, разбитые рамки и странные символы, нацарапанные на стенах. Из глубины дома доносится тихий шёпот. Слева — дверь в библиотеку. Справа — узкая лестница вниз, в подвал.', FALSE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 3, 'В библиотеке вы находите дневник владельца. Последняя запись гласит: «Он зовёт меня. Я не могу больше сопротивляться. Его голос — это истина. Все, кто слышат его, должны прийти». На последней странице — схема подвала.', FALSE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 4, 'Благодаря плану вы избегаете ловушек и находите железную дверь с рунами. За ней — тишина. Вы решаете открыть её.', FALSE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 5, 'Вы спускаетесь в темноту. Внезапно лестница рушится за вами. Шёпот становится громче. Из тьмы доносится голос, говорящий на непонятном языке. Он зовёт вас… и ваш разум начинает трещать по швам.', FALSE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 6, 'За дверью — круглая каменная комната. В центре — старинный монолит, покрытый трещинами. Из него медленно сочится чёрная слизь. Голос говорит: «Ты избран. Стань частью вечности». Вы чувствуете, как ваша плоть начинает меняться…', TRUE),
((SELECT id FROM quests WHERE title = 'Голос из подвала'), 7, 'Вы теряете сознание. Очнувшись, вы обнаруживаете, что стоите перед монолитом… но уже не помните, кто вы. Ваша кожа бледна, глаза чёрны. Голос теперь говорит внутри вас. Вы — новый хранитель.', TRUE);

-- Выборы: Кольб
INSERT INTO choices (from_step_id, to_step_id, text) VALUES
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 1), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 2), 'Перейти на страницу (2)'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 2), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 17), 'Войти в ледяную пещеру'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 2), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 8), 'Войти в пещеру, где гуляет ветер'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 2), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 12), 'Пойти по тропинке'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 3), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 16), 'Спуститься вниз'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 3), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 14), 'Заглянуть в таверну'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 4), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 9), 'Поднять щит'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 4), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 13), 'Замахнуться топором'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 5), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 15), 'Напасть на призрака'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 5), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 10), 'Дать призраку золото'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 10), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 7), 'Перейти на страницу (7)'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 7), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 16), 'Отправиться в логово дракона'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 7), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 14), 'Отправиться в таверну'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 12), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 3), 'Отправиться на холмы'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 12), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 5), 'Отправиться на болото'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 13), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 3), 'Перейти на страницу (3)'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 16), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 6), 'Нанести удар по шее'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 16), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 11), 'Нанести удар в брюхо'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 17), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 4), 'Пойти по вонючему тоннелю'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 17), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 8), 'Пойти по ветреному тоннелю'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 17), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Кольб и дракон') AND page_number = 12), 'Подняться по лестнице наверх');

-- Выборы: Лавкрафт
INSERT INTO choices (from_step_id, to_step_id, text) VALUES
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 1), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 2), 'Войти в дом'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 2), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 3), 'Пойти в библиотеку'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 2), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 5), 'Спуститься в подвал'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 3), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 2), 'Вернуться в холл'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 3), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 4), 'Спуститься в подвал, зная план'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 4), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 6), 'Открыть дверь'),
((SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 5), (SELECT id FROM steps WHERE quest_id = (SELECT id FROM quests WHERE title = 'Голос из подвала') AND page_number = 7), 'Идти на голос');