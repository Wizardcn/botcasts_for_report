class CategoryMock {
  String category;
  String image;

  CategoryMock(
    this.category,
    this.image,
  );

  static List<CategoryMock> categoryMockup() {
    return [
      CategoryMock(
        "ศิลปะ",
        "https://i.pinimg.com/564x/f6/2b/26/f62b26b7387968da8bd23aa504b0787e.jpg",
      ),
      CategoryMock(
        "ขำขัน",
        "https://static.vecteezy.com/system/resources/previews/003/530/264/non_2x/tv-drama-rgb-color-icon-vector.jpg",
      ),
      CategoryMock(
        "สารคดี",
        "https://i.pinimg.com/564x/32/88/6e/32886e8cdc26c6ef8c1e85f3b283b801.jpg",
      ),
      CategoryMock(
        "ข่าววันนี้",
        "https://i.pinimg.com/564x/09/cd/37/09cd3751f9e59f3bc82b982059e7b1c8.jpg",
      ),
      CategoryMock(
        "ธรรมมะ",
        "https://i.pinimg.com/564x/44/b9/3f/44b93f8619a0f24ec4a23455940d025c.jpg",
      ),
      CategoryMock(
        "ธุรกิจ",
        "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2019/10/business_with_esa/21093947-3-eng-GB/Business_with_ESA_pillars.jpg",
      ),
      CategoryMock(
        "สยองขวัญ",
        "https://cms.kapook.com/uploads/tag/42/ID_41475_5b7fd42816255.jpg",
      ),
      CategoryMock(
        "กีฬา",
        "https://www.chula.ac.th/wp-content/uploads/2018/03/trecs-hero-1440x900.jpg",
      ),
      CategoryMock(
        "วิดีโอเกม",
        "https://imageio.forbes.com/specials-images/dam/imageserve/927378732/960x0.jpg?format=jpg&width=960",
      ),
      CategoryMock(
        "วิทยาศาสตร์",
        "https://cdn.the-scientist.com/assets/articleNo/69216/aImg/43641/science-article-m.png",
      ),
      CategoryMock(
        "เทคโนโลยี",
        "https://ps-attachments.s3.amazonaws.com/cc810a17-c903-405a-b914-be7622637dc2/ixTAUT5DNBKQzZaBAixIkA.jpg",
      ),
    ];
  }
}
