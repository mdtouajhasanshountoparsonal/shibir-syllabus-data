# Content Schema

সব ফাইল UTF-8 JSON। অ্যাপ কেবল নিচের ফিল্ড পড়ে; অজানা ফিল্ড উপেক্ষা করা হয় (ভবিষ্যতে বাড়ানো নিরাপদ)।

## `manifest.json`

| Field | Type | বর্ণনা |
| --- | --- | --- |
| `schemaVersion` | int | স্কিমা ভার্সন। অ্যাপ কেবল `1` সমর্থন করে। |
| `contentVersion` | string | `major.minor.patch` — কনটেন্ট বদলালে বাড়াও। |
| `updatedAt` | string | `yyyy-MM-dd` |
| `stagesUrl` | string | stages ফাইলের URL (relative বা absolute) |
| `booksUrl` | string | books ফাইলের URL |
| `memorizationUrl` | string | memorization ফাইলের URL |
| `quizzesUrl` | string | quizzes ফাইলের URL |
| `scheduleUrl` | string | schedule ফাইলের URL (ঐচ্ছিক) |

## `stages.json`

```json
{
  "stages": [
    {
      "id": "worker",
      "title": "কর্মী",
      "subtitle": "প্রাথমিক অধ্যয়ন",
      "description": "…",
      "items": [
        {
          "id": "worker-book-1",
          "title": "…",
          "type": "book",
          "category": "reading",
          "bookId": "book_001",
          "description": "…",
          "author": "…",
          "sourceUrl": "",
          "estimatedMinutes": 30
        }
      ]
    }
  ]
}
```

`type` মান: `book` | `quran` | `hadith` | `memorization` | `other` | `assessment`

## `books.json`

```json
{
  "books": [
    {
      "id": "book_001",
      "title": "…",
      "author": "…",
      "publisher": "…",
      "language": "বাংলা",
      "edition": "১ম সংস্করণ",
      "pages": 120,
      "description": "…",
      "stage": "worker",
      "category": "reading",
      "format": "pdf",
      "coverUrl": "",
      "fileUrl": "",
      "externalUrl": "",
      "source": "প্রকাশক / বৈধ উৎস",
      "chapters": [
        { "id": "c1", "title": "প্রথম অধ্যায়", "pageStart": 1, "pageEnd": 30 }
      ]
    }
  ]
}
```

`format` মান: `pdf` | `epub` | `link`

> কপিরাইট অনুমতি না থাকলে `fileUrl` খালি রেখে শুধু `externalUrl` বা বইয়ের বিবরণ দাও।

## `memorization.json`

```json
{
  "items": [
    {
      "id": "memo_fatiha",
      "title": "সূরা আল-ফাতিহা",
      "arabic": "…",
      "transliteration": "…",
      "meaning": "…",
      "reference": "সূরা আল-ফাতিহা, আয়াত ১",
      "audioUrl": "",
      "stage": "worker"
    }
  ]
}
```

## `quizzes.json`

```json
{
  "quizzes": [
    {
      "id": "q_worker_1",
      "question": "…",
      "options": ["ক", "খ", "গ", "ঘ"],
      "correctIndex": 2,
      "explanation": "…",
      "stage": "worker"
    }
  ]
}
```

## `schedule.json`

মাসভিত্তিক পাঠসূচি (ঐচ্ছিক ফাইল)। `schedule` অবজেক্টে `years` → `months` থাকে।

```json
{
  "schedule": {
    "title": "কর্মীদের পাঠ মূল্যায়ন ও অধ্যয়ন সিলেবাস",
    "subtitle": "২০২৫ – ২০২৭ মাসভিত্তিক পাঠসূচি",
    "sourceUrl": "https://shibircloud.com/pdf/kormider_path_mulyayon_o_odhoyon_syllabus_2026.pdf",
    "sourceLabel": "সম্পূর্ণ সিলেবাস (PDF)",
    "notes": ["মাসিক ও বার্ষিক অতিরিক্ত লক্ষ্য …"],
    "years": [
      {
        "year": "২০২৬",
        "months": [
          {
            "id": "2026-01",
            "month": "জানুয়ারি",
            "quran": "সূরা আল মুদ্দাসির (১–৫)",
            "hadith": "এন্তেখাবে হাদিস (১ম ও ২য় খণ্ড) — [প্রথম অধ্যায় – চতুর্থ অধ্যায়]",
            "literature": ["কর্মপদ্ধতি (১ম অংশ)", "ঈমানের হাকীকত"],
            "discussion": "কর্মপদ্ধতি (১ম অংশ)",
            "practice": [
              { "label": "অর্থসহ সূরা মুখস্থ", "value": "সূরা আল ফাতিহা" }
            ]
          }
        ]
      }
    ]
  }
}
```

> প্রতিটি `month`-এর `id` স্থিতিশীল রাখতে হবে (যেমন `2026-01`)। `practice` ঐচ্ছিক।

## ID নিয়ম

- প্রতিটি `id` স্থিতিশীল ও ইউনিক হতে হবে।
- একটি ID একবার ব্যবহারের পর কখনো বদলাবে না — বদলালে ব্যবহারকারীর অগ্রগতি/নোট হারাবে।
- একই বই একাধিক স্তরে `bookId` দিয়ে বারবার উল্লেখ করা যায়; বইটি `books.json`-এ একবারই থাকবে।
