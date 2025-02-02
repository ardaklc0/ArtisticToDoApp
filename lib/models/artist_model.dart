class Artist {
  final String name;
  final String imagePath;
  final String artistId;
  final String artistDescription;
  final String? artistBirthDate;
  final String? artistDeathDate;
  Artist({
    required this.name,
    required this.imagePath,
    required this.artistId,
    required this.artistDescription,
    this.artistBirthDate,
    this.artistDeathDate,
  });
}

List<Artist> artistEntities = [
  Artist(
    name: 'Gustav Klimt',
    imagePath: 'assets/images/GustavKlimt/1.jpg',
    artistId: 'GustavKlimt',
    artistDescription:
    'Gustav Klimt was an Austrian symbolist painter'
        ' and one of the most prominent members of'
        ' the Vienna Secession movement. Klimt is noted'
        ' for his paintings, murals, sketches, and '
        'other objets d\'art. Klimt\'s primary subject',
    artistBirthDate: 'July, 1862',
    artistDeathDate: 'February, 1918',
  ),
  Artist(
    name: 'Monet',
    imagePath: 'assets/images/Monet/1.jpg',
    artistId: 'Monet',
    artistDescription: 'Oscar-Claude Monet was a French painter'
        ' and founder of impressionist painting who is'
        ' seen as a key precursor to modernism, especially'
        ' in his attempts to paint nature as he perceived it.'
        ' Monet was born in Paris but grew up in Le Havre,'
        ' where he first met Eugène Boudin, who encouraged'
        ' him to paint out of doors. Monet was enrolled in'
        ' the studio of Glenyre, where he met Pierre-Auguste'
        ' Renoir and Frédéric Bazille.',
    artistBirthDate: 'November, 1840',
    artistDeathDate: 'December, 1926',
  ),
  Artist(
    name: 'Picasso',
    imagePath: 'assets/images/Picasso/1.jpg',
    artistId: 'Picasso',
    artistDescription: 'Pablo Ruiz Picasso was a Spanish painter,'
        ' sculptor, printmaker, ceramicist and theatre designer'
        ' who spent most of his adult life in France. Regarded as'
        ' one of the most influential artists of the 20th century,'
        ' he is known for co-founding the Cubist movement, the'
        ' invention of constructed sculpture, the co-invention of'
        ' collage, and for the wide variety of styles that he helped'
        ' develop and explore.',
    artistBirthDate: 'October, 1881',
    artistDeathDate: 'April, 1973',
  ),
  Artist(
    name: 'Dali',
    imagePath: 'assets/images/SalvadorDali/1.jpg',
    artistId: 'SalvadorDali',
    artistDescription: 'Salvador Domingo Felipe Jacinto Dalí i Domènech,'
        ' 1st Marquis of Dalí de Púbol was a Spanish surrealist artist'
        ' renowned for his technical skill, precise draftsmanship and'
        ' the striking and bizarre images in his work. Born in Figueres,'
        ' Catalonia, Dalí received his formal education in fine arts at'
        ' Madrid. Influenced by Impressionism and the Renaissance masters'
        ' from a young age, he became increasingly attracted to Cubism and'
        ' avant-garde movements.',
    artistBirthDate: 'May, 1904',
    artistDeathDate: 'January, 1989',
  ),
  Artist(
    name: 'Osman Hamdi',
    imagePath: 'assets/images/OsmanHamdi/1.jpg',
    artistId: 'OsmanHamdi',
    artistDescription: 'Osman Hamdi Bey was an Ottoman administrator,'
        ' intellectual, art expert and also a prominent and pioneering'
        ' painter. He was also an accomplished archaeologist, and is'
        ' considered as the pioneer of the museum curator\'s profession'
        ' in Turkey. He was the founder of Istanbul Archaeology Museums'
        ' and of the Istanbul Academy of Fine Arts (Sanayi-i Nefise Mekteb-i'
        ' Alisi), known today as the Mimar Sinan University of Fine Arts.',
    artistBirthDate: 'December, 1842',
    artistDeathDate: 'February, 1910',
  ),
  Artist(
    name: 'Van Gogh',
    imagePath: 'assets/images/VanGogh/1.jpg',
    artistId: 'VanGogh',
    artistDescription: 'Vincent Willem van Gogh was a Dutch post-impressionist'
        ' painter who is among the most famous and influential figures in the'
        ' history of Western art. In just over a decade, he created about 2,100'
        ' artworks, including around 860 oil paintings, most of which date from'
        ' the last two years of his life. They include landscapes, still lifes,'
        ' portraits and self-portraits, and are characterised by bold colours and'
        ' dramatic, impulsive and expressive brushwork that contributed to the foundations'
        ' of modern art.',
    artistBirthDate: 'March, 1853',
    artistDeathDate: 'July, 1890',
  ),
  Artist(
    name: 'Jan Vermeer',
    imagePath: 'assets/images/JohannesVermeer/1.jpg',
    artistId: 'JohannesVermeer',
    artistDescription: 'Johannes Vermeer was a Dutch Baroque Period painter who'
        ' specialized in domestic interior scenes of middle-class life. During his'
        ' lifetime, he was a moderately successful provincial genre painter, recognized'
        ' in Delft and The Hague. Nonetheless, he produced relatively few paintings and'
        ' evidently was not wealthy, leaving his wife and children in debt at his death.',
    artistBirthDate: 'October, 1632',
    artistDeathDate: 'December, 1675',
  ),
  Artist(
    name: 'Cezanne',
    imagePath: 'assets/images/Cezanne/1.jpg',
    artistId: 'Cezanne',
    artistDescription: 'Paul Cézanne was a French artist and Post-Impressionist painter'
        ' whose work laid the foundations of the transition from the 19th-century conception'
        ' of artistic endeavor to a new and radically different world of art in the 20th century.'
        ' Cézanne\'s often repetitive, exploratory brushstrokes are highly characteristic and'
        ' clearly recognizable. He used planes of colour and small brushstrokes that build up to'
        ' form complex fields, at once both a direct expression of the sensations of the observing'
        ' eye and an abstraction from observed nature.',
    artistBirthDate: 'January, 1839',
    artistDeathDate: 'October, 1906',
  ),
  Artist(
      name: 'Edvard Munch',
      imagePath: 'assets/images/EdvardMunch/1.jpg',
      artistId: 'EdvardMunch',
      artistDescription: 'Edvard Munch was a Norwegian painter and printmaker whose intensely '
          'evocative treatment of psychological themes built upon some of the main tenets of '
          'late 19th-century Symbolism and greatly influenced German Expressionism in the early '
          '20th century. His best-known work is The Scream, painted in 1893. Munch\'s work '
          'is known for its dramatic and expressive treatment of emotion. Munch\'s father'
          ' died of tuberculosis in 1868, and his mother died of the same disease in 1869. '
          'Munch was raised by his father\'s brother, Christian Munch, who was a priest. '
          'Christian Munch\'s strict religious temperament was a source of much discord for Edvard, '
          'who often rebelled against him.',
    artistBirthDate: 'December, 1863',
    artistDeathDate: 'January, 1944',
  ),
  Artist(
      name: 'Kandinsky',
      imagePath: 'assets/images/Kandinsky/1.jpg',
      artistId: 'Kandinsky',
      artistDescription: 'Wassily Wassilyevich Kandinsky was a Russian painter and art theorist. '
          'Kandinsky is generally credited as the pioneer of abstract art. Born in Moscow, Kandinsky '
          'spent his childhood in Odessa, where he graduated at Grekov Odessa Art school. He enrolled '
          'at the University of Moscow, studying law and economics. Successful in his profession—he was '
          'offered a professorship at the University of Dorpat—Kandinsky began painting studies (life-drawing, '
          'sketching and anatomy) at the age of 30.',
    artistBirthDate: 'December, 1866',
    artistDeathDate: 'December, 1944',
  )
];