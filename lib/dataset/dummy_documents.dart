import 'package:flutter/material.dart';

import '../models/document.dart';

const nagariktaImgURL =
    'https://scontent.fktm1-2.fna.fbcdn.net/v/t1.6435-9/86265665_514718655838386_6235550399277826048_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=O3Pqxxh0XV0AX9bgjhc&_nc_ht=scontent.fktm1-2.fna&oh=00_AT_DunItJCWLI0DMQgeQjyXGfI4T7p1qywBK1HfR6MSa-Q&oe=6220B9DB';
const licenceImgURL =
    'https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/04/Smart-driving-licence-specimen.jpg';
const slcImgURL =
    'https://leverageedu.com/blog/wp-content/uploads/2021/05/SLC2-01-1024x791.jpg';

const passportImgURL =
    'https://ultrareproduction.com/wp-content/uploads/2021/04/uk-passport.jpg';

const khopCardImgURL =
    'https://vaccine.mohp.gov.np/images/khop_card.jpg?ff2c4af8149164d4907942fdb3d48ca2';

final DUMMY_DOCS = [
      Document(
        id: 'id1',
        title: 'Citizenship',
        tags: ['Government'],
        note: 'This is my Fake Nagarikta',
        images: [
          Image.network(
            nagariktaImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            nagariktaImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            nagariktaImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
        ],
      ),
      Document(
        id: 'id2',
        title: 'Licence',
        tags: ['Government', 'Bike'],
        note: 'This is my Fake Licence',
        images: [
          Image.network(
            licenceImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            licenceImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            licenceImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
        ],
      ),
      Document(
        id: 'id3',
        title: 'School Leaving Certificate',
        tags: ['Education', 'School'],
        note: 'This is my Fake School leaving certificate',
        images: [
          Image.network(
            slcImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            slcImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            slcImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
        ],
      ),
      Document(
        id: 'id4',
        title: 'Passport',
        tags: ['Government'],
        note: 'This is my Fake Passport',
        images: [
          Image.network(
            passportImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            passportImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            passportImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
        ],
      ),
      Document(
        id: 'id5',
        title: 'Khop Card',
        tags: ['Government', 'Covid'],
        note: 'This is my Fake Khop Card',
        images: [
          Image.network(
            khopCardImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            khopCardImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
          Image.network(
            khopCardImgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            semanticLabel: 'Nagarikta',
          ),
        ],
      ),
    ] +
    veryLongList;

var veryLongList = List.generate(50, (index) {
  return Document(
    id: 'id${50 + index}',
    title: 'Certificate ${index + 1}',
    tags: ['tag1', 'tag2'],
    note: 'This is my Fake Certificate',
    images: [
      Image.network(
        slcImgURL,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        semanticLabel: 'Certificate',
      ),
      Image.network(
        slcImgURL,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        semanticLabel: 'Certificate',
      ),
      Image.network(
        slcImgURL,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        semanticLabel: 'Certificate',
      ),
    ],
  );
});
