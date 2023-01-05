import random
import time
import mysql.connector
import string
mydb = mysql.connector.connect(host="localhost",  user="root",  password="CSed2024!",  database="BookStore")
mycursor = mydb.cursor()


book_titles = [
    'The Grapes of Wrath',
    'Gargantua and Pantagruel',
    'Tristram Shandy',
    'Emma',
    'The Good Soldier',
    'Gone With the Wind',
    'Madame Bovary',
    'The Canterbury Tales',
    'The Metamorphosis',
    'Pride and Prejudice',
    'The Sun Also Rises',
    'The Red and the Black',
    'The Old Man and the Sea',
    'The Great Gatsby',
    'Oedipus',
    'David Copperfield',
    'The Scarlet Letter',
    'Ulysses',
    ' Oedipus at Colonus',
    "The Handmaid's Tale",
    'Anna Karenina',
    'War and Peace',
    'The Divine Comedy',
    'Game of Thrones',
    'Lord of the Flies',
    'The Flowers of Evil',
    'Vanity Fair',
    'Robinson Crusoe',
    'To Kill a Mockingbird',
    'In Search of Lost Time',
    'The Odyssey',
    'Lolita',
    "Tess of the d'Urbervilles",
    'Moby Dick',
    'Alice Adventures in Wonderland',
    'Hamlet',
    'Invisible Man',
    'To the Lighthouse',
    'The Brothers Karamazov ',
    "Gulliver's Travels",
    'Les Misérables',
    'One Thousand and One Nights',
    'One Hundred Years of Solitude',
    'Paradise Lost',
    'Great Expectations',
    'Don Quixote',
    'Nineteen Eighty Four',
    'The Sound and the Fury',
    'Wuthering Heights',
    'The Magic Mountain',
    'The Lord of The Rings'
               ]

book_authors = [
    'Dr. Seuss',
    'F. Scott Fitzgerald',
    'G.R.R. Martin',
    "Flannery O'Connor",
    'Nathaniel Hawthorne',
    'Agatha Christie',
    'Jin Yong',
    'Franz Kafka',
    'Ralph Waldo Emerson',
    'Rachel Hollis',
    'Alexander Pushkin',
    'Stephen King',
    'Edith Wharton',
    'Margaret Atwood',
    'Mark Twain',
    'Paulo Coelo',
    'T. S. Eliot',
    'Ray Bradbury',
    'Danielle Steel',
    'Stephenie Meyer',
    'Walt Whitman',
    'Jane Austen',
    'Alexandre Dumas',
    'Barbara Cartland',
    'Kurt Vonnegut',
    'Doris Lessing',
    'Oscar Wilde',
    'Jack London',
    'Horatio Alger',
    'J. R. R. Tolkien',
    'Robert Frost',
    'Bella Forrest',
    'Henry James',
    'J. K. Rowling',
    'Cormac McCarthy',
    'Carolyn Brown',
    'John Steinbeck',
    'Emily Dickinson',
    'Edgar Allan Poe',
    'C.S. Lewis',
    'Carlos Ruiz Zafon',
    'Tennessee Williams',
    'William Faulkner',
    'Harper Lee',
    'Herman Melville',
    'Guillaume Musso',
    'Mary Shelley',
    'Ernest Hemingway',
    'Jules Verne',
    'William Shakespeare',
    'Leo Tolstoy'
]

book_categories = [
    'Science',
    'Art' ,
    'Religion',
    'History',
    'Geography'
]

images_URLs = ['https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg' ,
               'https://149349728.v2.pressablecdn.com/wp-content/uploads/2019/08/The-Crying-Book-by-Heather-Christie-1.jpg'
               'https://iasst.org/e/wp-content/uploads/2020/05/book-img2.jpg',
               'https://iasst.org/e/wp-content/uploads/2020/05/book-img2.jpg',
               'https://mir-s3-cdn-cf.behance.net/projects/404/2bc4b6123511641.Y3JvcCwxODM4LDE0MzgsNTgyLDEyMg.jpg',
               'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1637012564',
               'https://www.nme.com/wp-content/uploads/2022/01/Valorant-Neon-2000x1270-1.jpg',
               'https://static.wikia.nocookie.net/valorant/images/d/db/VALORANT_Jett_Card_Large.jpg/revision/latest/scale-to-width-down/125?cb=20200910061435',
               'https://static.wikia.nocookie.net/valorant/images/5/55/VALORANT_Fade_Card_Large.png/revision/latest/scale-to-width-down/125?cb=20220427142605',
               'https://edit.org/photos/images/cat/book-covers-big-2019101610.jpg-1300.jpg',
               'https://rivetedlit.com/wp-content/uploads/2020/01/all-this-time-9781534466340_xlg.jpg',
               'https://s26162.pcdn.co/wp-content/uploads/2018/02/gatsby-original2.jpg',
               'https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg?width=400&format=jpeg&optimize=medium',
               'https://www.creativeparamita.com/wp-content/uploads/2021/01/The-Girl-Who-Never-1.jpg',
               'https://www.creativeparamita.com/wp-content/uploads/2021/01/The-Girl-Who-Never-1.jpg',
               'https://static-cse.canva.com/blob/921487/ColorfulIllustrationYoungAdultBookCover.jpg',
               'http://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg',
               'https://www.creativindie.com/wp-content/uploads/2017/04/New-WOrld-299x449.jpg',
               'https://static01.nyt.com/images/2020/12/20/books/review/20BestBookCovers-11/20BestBookCovers-11-mobileMasterAt3x.jpg',
               'https://i.guim.co.uk/img/media/af1ea48f1eeaab4300691b35f585d326e6ed24bb/0_0_784_1200/master/784.jpg?width=700&quality=85&auto=format&fit=max&s=07b76b55b36cf2f0b56086c33d9e2763',
               'https://dryuc24b85zbr.cloudfront.net/tes/resources/6441170/image?width=500&height=500&version=1474643904786',
               'https://dryuc24b85zbr.cloudfront.net/tes/resources/6441170/image?width=500&height=500&version=1474643904786',
               'https://dryuc24b85zbr.cloudfront.net/tes/resources/6441170/image?width=500&height=500&version=1474643904786',
               'https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781421576824/naruto-vol-68-9781421576824_hr.jpg',
               'https://m.media-amazon.com/images/I/51uO-K+V5dL._AC_SY1000_.jpg',
               'https://m.media-amazon.com/images/I/610lS3Qtt2L._AC_SY780_.jpg',
               'https://list.lisimg.com/image/3852312/500full.jpg',
               'https://www.rightstufanime.com/images/productImages/9781421558851_manga-Naruto-Graphic-Novel-63-primary.jpg?resizeid=3&resizeh=600&resizew=600',
               'https://www.rightstufanime.com/images/productImages/9781421558851_manga-Naruto-Graphic-Novel-63-primary.jpg?resizeid=3&resizeh=600&resizew=600',
               'https://www.rightstufanime.com/images/productImages/9781421558851_manga-Naruto-Graphic-Novel-63-primary.jpg?resizeid=3&resizeh=600&resizew=600',
               'https://cdn.animenewsnetwork.com/thumbnails/max600x600/cms/interest/113659/news_xlarge_shocomi_conan_clearfile_a.jpg',
               'https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2014/7/30/1406719264487/fd90e162-93de-41b1-aea5-f8e49227e85b-1360x2040.jpeg?width=700&quality=85&auto=format&fit=max&s=28732c5a7caa1d1249d3f420e247479b',
               'http://universe.byu.edu/wp-content/uploads/2015/01/HP4cover.jpg',
               'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2016%2F09%2F9781408855652-png.jpg',
               'https://images.ctfassets.net/usf1vwtuqyxm/3d9kpFpwHyjACq8H3EU6ra/85673f9e660407e5e4481b1825968043/English_Harry_Potter_4_Epub_9781781105672.jpg?w=914&q=70&fm=jpg',
               'https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-fall-2019/large/bbcdune.jpg?1384968217',
               'https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-fall-2019/large/bbcdune.jpg?1384968217',
               'https://rivetedlit.com/wp-content/uploads/2018/09/five-feet-apart-9781534437333_hr-679x1024.jpg',
               'https://ychef.files.bbci.co.uk/976x549/p08g0rvp.jpg',
               'https://creativereview.imgix.net/content/uploads/2021/12/Being-A-Human_Charles-Foster_Mock-Up-scaled.jpg?auto=compress,format&q=60&w=1852&h=2560',
               'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2017/10/the-50-coolest-book-covers-47.jpg',
               'https://cdn.pastemagazine.com/www/system/images/photo_albums/30-best-book-covers-2016/large/2vegetariancover.png?1384968217',
               'https://cdn.pastemagazine.com/www/system/images/photo_albums/30-best-book-covers-2016/large/2vegetariancover.png?1384968217',
               'https://www.adobe.com/express/create/cover/media_181e3d2c78f153ae7bf0e19a2faeb9a76e234da30.jpeg?width=400&format=jpeg&optimize=medium',
               'https://getcovers.com/wp-content/uploads/2022/01/cover-4-scaled-e1642585532356.jpeg',
               'https://images-platform.99static.com//dRauXPdQNl9FcOHyZ2lFfA2ONJ8=/410x163:1321x1074/fit-in/500x500/99designs-contests-attachments/112/112162/attachment_112162890',
               'https://thebooksatchel.com/wp-content/uploads/2020/07/follow-me-to-the-ground.jpg',
               'https://s26162.pcdn.co/wp-content/uploads/2022/01/81OjmEpeS3S-670x1024.jpg',
               'https://theaoi.com/wp-content/uploads/2022/02/quimtorres_encounters_image1-1-1263x1200.jpg',
               'https://www.baileydesignsbooks.com/wp-content/uploads/2020/05/gardenwall.jpg',
               'https://www.thatartsyreadergirl.com/wp-content/uploads/2018/05/TTT-Purple1.jpg',
               'https://www.thatartsyreadergirl.com/wp-content/uploads/2018/05/TTT-Purple1.jpg',
               'https://i0.wp.com/www.printmag.com/wp-content/uploads/2021/12/b960fb_d7966c40128e4b16830028749603f826mv2-1.jpeg?resize=851%2C902&ssl=1',
               'https://observer.com/wp-content/uploads/sites/2/2022/10/LaurenPeters-Collaer%E2%80%94VanishingHalf.jpeg?quality=80',
               'https://assets.teenvogue.com/photos/5cd2d85354a1342b5187a5c4/master/w_1688,h_2550,c_limit/TheGravityofUs_cata_9781547600144%20.jpg',
               ]

publishers = [
    'John Wiley & Sons, Inc.',
    'Scholastic, Inc.',
    'Pearson',
    'Merriam-Webster Inc.',
    'HarperCollins Publishers',
    'Houghton Mifflin Harcourt',
]

addresses = [
    'Monroe Street, 6749', 'Caroline  Pass, 3118',
    'Angela   Avenue, 8874', 'Belmore  Crossroad, 8023',
    'Bellenden  Vale, 1640', 'Collins  Grove, 8300',
    'Bliss  Walk, 3599', 'Adams  Walk, 6541',
    'Bermondsey    Avenue, 131', 'Bolton  Lane, 2844',
    'Walnut Route, 544', 'Dutton   Alley, 4708', 'Victoria  Way, 5693',
    'Bolton  Crossroad, 1166', 'Dutton   Crossroad, 1619',
    'Adams  Crossroad, 2442', 'Besson  Road, 5202', 'North Pass, 283',
    'Paris   Road, 2490', 'Dunton  Pass, 5755', 'Marischal  Lane, 580',
    'Chester  Crossroad, 9741', 'Arundel   Vale, 8006',
    'Elgood   Crossroad, 5816', 'South Pass, 3168',
    'Meadow Lane, 6031', 'Linden Route, 4770', 'Empress  Alley, 9360',
    'Cleveland  Lane, 4019', 'Timothy  Crossroad, 5569',
    'Lake Street, 6147', 'Elgood   Way, 2021', 'Lincoln Avenue, 9520',
    'Bekesbourne   Tunnel, 1488', 'Lexington Grove, 7392',
    'Norland  Tunnel, 3836', 'Cadogan  Street, 1561',
    'Lake Walk, 5022', 'Baynes  Avenue, 4461',
    'Battersea   Crossroad, 1341', 'Cockspur  Drive, 6543',
    'Cam  Lane, 2654', 'Linden Vale, 3569', 'Clere  Walk, 1578',
    'Victorian  Tunnel, 3841', 'Lonsdale  Drive, 9773',
    'Adams  Walk, 5923', 'King Edward  Vale, 2606',
    'Bayberry Hill, 8791', 'Amwell    Route, 1967',
    'Fairfield  Rue, 3891', 'Emden   Route, 866',
    'Bingham   Rue, 1400', 'Duthie   Rue, 6912', 'Magnolia Rue, 3661',
    'Mariner   Avenue, 9679', 'Colombo   Pass, 3858',
    'Boldero   Road, 791', 'Clere  Drive, 8685', 'Glenwood Hill, 1486',
    'Cephas  Vale, 5356', 'Monroe Rue, 1556', 'Tilloch   Hill, 9087',
    'Betton  Drive, 7464', 'Chester  Street, 6121', 'Cam  Drive, 1803',
    'Callcott   Alley, 3246', 'Ellerslie Walk, 5803',
    'Sundown Pass, 2691', 'Balham   Route, 3252',
    'Bethwin  Grove, 1349', 'Burton  Crossroad, 1007',
    'Longman   Drive, 6945', 'Boldero   Drive, 8387',
    'Beaumont  Walk, 9926', 'Enford   Drive, 9899',
    'Blanchard  Crossroad, 7713', 'Durham Boulevard, 2166',
    'Arbutus   Way, 8857', 'Egerton  Pass, 8078',
    'Badric  Alley, 8296', 'Woodland Grove, 667',
    'Glenwood Avenue, 6786', 'Edwin   Grove, 4915',
    'Carlton  Crossroad, 2151', 'Thurloe   Rue, 565',
    'Castlereagh   Street, 3900', 'Carnegie   Tunnel, 1540',
    'Capeners  Way, 4974', 'Bliss  Tunnel, 9748',
    'Victoria  Tunnel, 4536', 'Cleveland  Pass, 426',
    'Dutton   Road, 5715', 'Clarges   Lane, 2485',
    'Blendon    Road, 1145', 'Longleigh   Alley, 6046',
    'Cingworth  Boulevard, 6870', 'Apsley    Drive, 4753',
    'Birkin   Tunnel, 2568', 'Buttonwood Grove, 2038'
]

phones = [
    '6-351-428-7438', '7-602-422-1250', '2-003-218-8872',
    '1-688-741-1421', '3-672-362-0337', '4-408-837-5860',
    '0-833-634-7472', '4-664-022-0780', '4-765-287-2202',
    '6-827-545-1722', '4-862-163-8648', '4-684-754-5887',
    '1-730-627-5107', '6-501-048-0136', '6-705-217-5684',
    '8-612-661-1428', '4-316-086-2544', '2-658-334-1183',
    '7-735-815-2228', '3-518-226-7776', '8-531-116-4602',
    '3-423-385-3312', '1-638-576-8682', '2-807-712-4746',
    '5-183-387-4828', '8-341-614-2400', '8-278-547-4184',
    '4-275-611-2743', '2-157-488-6154', '3-302-765-6060',
    '5-788-451-6712', '1-832-327-6461', '1-477-613-6148',
    '2-403-121-4141', '2-124-815-4617', '0-060-555-0131',
    '4-335-002-6022', '4-753-086-8537', '1-085-151-3374',
    '4-844-474-0878', '1-421-841-5154', '3-857-157-0407',
    '7-230-764-1614', '6-465-237-2503', '6-822-756-5074',
    '1-004-508-3538', '4-272-647-4184', '4-451-302-2106',
    '3-431-546-1421', '0-771-580-0538', '5-641-750-8041',
    '8-825-186-0156', '5-761-564-5060', '7-835-504-1812',
    '1-768-062-1325', '0-572-737-6184', '4-750-851-1754',
    '2-213-687-5743', '2-388-357-8020', '0-004-754-5325',
    '7-238-421-7450', '5-840-826-2282', '8-644-765-2872',
    '1-667-003-1826', '3-108-484-8553', '8-453-850-8342',
    '3-522-182-2640', '1-103-774-8703', '6-825-538-2207',
    '8-353-876-1466', '4-050-534-0135', '7-204-861-4125',
    '2-217-865-8538', '0-185-732-7630', '5-750-065-3847',
    '7-881-306-5766', '7-713-447-6386', '1-717-466-8636',
    '3-706-565-5508', '5-584-566-0171', '0-267-130-5177',
    '4-167-670-8316', '8-832-707-1070', '7-606-518-7354',
    '2-365-581-1687', '5-140-617-7356', '6-666-330-7058',
    '2-205-757-0426', '3-875-371-1483', '4-312-776-3250',
    '0-234-340-0260', '1-321-840-4808', '0-886-206-4687',
    '2-510-225-7505', '2-103-551-7302', '0-824-764-6875',
    '2-027-522-4665', '3-163-266-6010', '2-181-082-2786',
    '5-456-723-6244'
]

full_names = [
        'Sabina Whinter', 'Maggie Wise', 'Julius Tanner', 'Elena Abbot',
        'Hank Villiger', 'Noemi Nielson', 'Roger Hewitt',
        'Cadence Hastings', 'Katelyn Tate', 'Oliver Downing',
        'Danielle Holt', 'Brad Quinnell', 'Judith Burge',
        'Katelyn Spencer', 'Ethan Wheeler', 'Chad Jenkin', 'Davina Little',
        'Ramon King', 'Clint Burnley', 'Owen Rixon', 'Sadie Lloyd',
        'Tara Kent', 'Wade Santos', 'Carissa Giles', 'Daniel May',
        'Scarlett Rogers', 'Elijah Abbot', 'Elisabeth Snell', 'Abbey Lee',
        'Carl Kennedy', 'Johnathan Martin', 'Rhea Samuel',
        'Angelina Tyler', 'Chadwick Bullock', 'Johnny Walton',
        'Rufus Latham', 'Elise Ward', 'Barney Hobbs', 'Daron Donovan',
        'Hank Larsen', 'Nate Steer', 'Ramon Overson', 'Lara Booth',
        'Doug Casey', 'Belinda Broomfield', 'Owen Foxley', 'Doug Jackson',
        'Hayden Snell', 'Valerie Rossi', 'Harry Larkin', 'Christy Mcneill',
        'Nancy Taylor', 'Brad Yoman', 'Alessia Rogan', 'Dalia Payne',
        'Rosalyn Vinton', 'Leroy Wilde', 'Tiffany Bullock',
        'Nicholas Weasley', 'Paige Irwin', 'Bob Slater', 'Nathan Richards',
        'Roger Addis', 'Peter Richards', 'Domenic Allen', 'Noemi Leigh',
        'Martin Thorne', 'Natalie Vince', 'Emery Morrison',
        'Maddison Griffiths', 'Carol Hilton', 'Harry Foxley',
        'Javier Stubbs', 'Daniel Penn', 'Joseph Gonzales', 'Fred Everett',
        'Grace Jobson', 'Daron Roscoe', 'Melinda Janes', 'Anthony Spencer',
        'Piper Grady', 'Jayden Casey', 'Estrella Casey', 'Analise Yard',
        'Payton Thompson', 'Brooklyn Lynn', 'Alexander Mason',
        'Benjamin Carter', 'Logan Rycroft', 'Shannon Campbell',
        'Josh Durrant', 'Hanna Harris', 'Shay Ripley', 'Hayden Barclay',
        'Britney Bingham', 'Freya Squire', 'Danny Mcneill',
        'Liam Alldridge', 'Caydence Palmer', 'Benny Mooney'
]

names = []
for i in full_names:
    names += i.split()




letters = list(string.ascii_letters)

data = {
    'user'      : ('user_name' ,'pass', 'first_name' , 'last_name'  , 'email' , 'phone' , 'address' , 'is_manager' ),
                                                           #publication year
    'book'            : ('id' , "book_title" , "publisher" , "date" ,  "price" ,
                         "category" , "stock" , "threshold" , "image_url"), #id is char(13)
    'author'    : ('id' , 'author'),#id is book id

    'sale'      : ('id' , 'existed_username' , 'existed_ISBN' , 'sale_amount' , 'date' , 'price')


    # 'publisher'       : ("publisher" , "address" , "phone"),
}


"""
num of books = 1M
Avg num of authors = 500K
"""

start = time.time()
min_stock = 5
max_stock = 25
min_price = 50
max_price = 1000


# insert into publisher
publishers_addresses = random.sample(addresses , len(publishers))
publishers_phones = random.sample(phones , len(publishers))
for publisher , address , phone in zip(publishers , publishers_addresses , publishers_phones):
    sql = f"INSERT INTO publisher VALUES (%s,%s,%s)"
    values = (publisher , address , phone)
    mycursor.execute(sql , values)
mydb.commit()



#insert into remaining tables
sqls = []
valuesList = []
for table,table_count in  zip(data.keys(),range(len(data.keys()))):
    table_start_time = time.time()
    if table == 'book':
        n = int(1*1e6)
    elif table == 'user':
        n = 100
    elif table == 'author':
        n = int(5*1e5)
    elif table == 'sale':
        n = 5000
        mycursor.execute("SELECT ISBN FROM Book")
        existed_ISBNs = mycursor.fetchall()
        existed_ISBNs = [i[0] for i in existed_ISBNs]

        mycursor.execute("SELECT username FROM user")
        existed_usernames = mycursor.fetchall()
        existed_usernames = [i[0] for i in existed_usernames]

        print(existed_ISBNs)
        print(existed_usernames)



    print(f"\n************** {table} ***************\n")
    cols_num = len(data[table])
    for id in range(n-1):
        if table == 'user':
            first_name = random.choice(names)
            last_name = random.choice(names)
            user_name = f"{first_name}_{last_name}-{id}"
        values = []
        sql = f"INSERT INTO {table} VALUES ("
        for v,i in zip(data[table],range(cols_num)):
            if v == 'id':
                values.append(id)
            elif v == 'threshold':
                values.append(f"{random.randint(5 , 10)}")
            elif v == 'book_title':
                values.append(random.choice(book_titles))
            elif v == 'publisher':
                values.append(random.choice(publishers))
            elif v == 'author':
                values.append(random.choice(book_authors))
            elif v == 'price':
                values.append(f"{random.randint(min_price , max_price)}")
            elif v == 'date' :
                values.append(f"{2022}-{random.randint(1 , 12)}-{random.randint(1 , 28)}")
            elif v == 'stock' :
                values.append(f"{random.randint(min_stock , max_stock)}")
            elif v == 'image_url' :
                values.append(random.choice(images_URLs))
            elif v == 'category':
                values.append(random.choice(book_categories))
            elif v == 'user_name':
                values.append(user_name)
            elif v == "email":
                values.append(f"user_name-{id}@gmail.com")
            elif v == "first_name":
                values.append(first_name)
            elif v == "last_name":
                values.append(last_name)
            elif v == "phone":
                values.append(random.choice(phones)[0:11])
            elif v == "address" :
                values.append(random.choice(addresses))
            elif v == 'pass':
                values.append("".join(random.choices(letters,k = 10) ))
            elif v == 'existed_username':
                values.append(random.choice(existed_usernames))
            elif v == 'existed_ISBN':
                values.append(random.choice(existed_ISBNs))
            elif v == 'sale_amount':
                values.append(random.randint(1 , 20))
            elif v == "is_manager":
                if random.random() > 0.9:
                    b = 1
                else:
                    b = 0
                values.append(str(b))
            else:
                values.append(f"{v}-{id}")
            sql += '%s)' if i == cols_num-1 else '%s, '
        values = tuple(values)

        # print(values)
        # print()
        # print(sql)
        # print(values)
        mycursor.execute(sql, values)
        if (id % (n/20)) ==0:
            secsPerN = time.time() -start
            print(f"{id / n *100}%")
            print(f"{round(  ((n- id)/(n/20)) * secsPerN/60  ) } minutes remaining\n")
            start = time.time()
    mydb.commit()


    secsPertable = time.time()- table_start_time
    print(f"total minutes remaining = {round(  (6- table_count) * secsPertable/60  ) } mins \n")
    table_start_time = time.time()

mydb.disconnect()


