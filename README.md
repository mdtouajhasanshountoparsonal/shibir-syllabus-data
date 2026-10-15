# shibir-syllabus-data

Offline-first **Shibir Syllabus Tracker** অ্যাপের জন্য GitHub-হোস্টেড কনটেন্ট রিপোজিটরি।

অ্যাপটি একবার ইনস্টল হবে, আর এই রিপোতে JSON যোগ/আপডেট করলেই নতুন বই, সিলেবাস, মুখস্থ ও কুইজ সব ব্যবহারকারীর কাছে পৌঁছে যাবে — **নতুন APK তৈরি না করেই**।

## ফাইল কাঠামো

```
manifest.json       # ভার্সন ও প্রতিটি ফাইলের URL (এখান থেকেই সিংক শুরু হয়)
stages.json         # সিলেবাসের বিষয় (কর্মী সিলেবাসের ৭টি বিষয়) ও আইটেম
books.json          # ডিজিটাল লাইব্রেরির বই, অধ্যায়, PDF ও পাঠের লিংক
memorization.json   # মুখস্থ আইটেম (আয়াত, হাদিস, দোয়া)
quizzes.json        # মূল্যায়ন কুইজ
schedule.json       # ২০২৫–২০২৭ মাসভিত্তিক পাঠসূচি ও অতিরিক্ত নির্দেশনা
programs.json       # সর্বোচ্চ স্তরের সিলেবাস (কর্মী / সাথী / সদস্য) ও তাদের বিষয়-ক্রম
```

## সেটআপ (একবারই)

1. GitHub-এ একটি repo তৈরি করো, যেমন `shibir-syllabus-data` (Public রাখলেই সহজ)।
2. এই ফোল্ডারের সব ফাইল repo-তে পুশ করো:
   ```bash
   cd shibir-syllabus-data
   git init
   git add .
   git commit -m "Initial syllabus content"
   git branch -M main
   git remote add origin https://github.com/<USERNAME>/shibir-syllabus-data.git
   git push -u origin main
   ```
3. raw manifest URL নাও:
   ```
   https://raw.githubusercontent.com/<USERNAME>/shibir-syllabus-data/main/manifest.json
   ```
4. অ্যাপ খুলে **সেটিংস → GitHub কনটেন্ট সিংক → রিপো URL বসাও** — অথবা কোডে ডিফল্ট হিসেবে বসাতে চাইলে `lib/core/constants/app_constants.dart`-এর `githubManifestUrl`-এ লিংক দাও।

## প্রতিবার কনটেন্ট আপডেটের নিয়ম

1. প্রাসঙ্গিক JSON ফাইল সম্পাদনা করো (ID কখনো বদলাবে না)।
2. `manifest.json`-এর `contentVersion` বাড়াও — যেমন `1.0.0 → 1.0.1`।
   ```bash
   ./bump_version.sh          # patch
   ./bump_version.sh minor    # minor
   ```
3. commit + push করো। অ্যাপ পরের বার অনলাইনে এলে নতুন ভার্সন ডাউনলোড করবে।
4. ব্যর্থ ডাউনলোড কখনো পুরোনো ক্যাশ মুছবে না; নতুন JSON যাচাইয়ের পরেই প্রতিস্থাপিত হয়।

## নিরাপত্তা নিয়ম

- **একই আইটেমের `id` কখনো বদলাবে না** — স্থিতিশীল ID রাখলে ব্যবহারকারীর অগ্রগতি/নোট হারায় না।
- ভুল টাইপ বা ভাঙা JSON পুশ করলে অ্যাপ সেটি গ্রহণ করবে না (validation আছে)।
- ব্যক্তিগত নোট বা ব্যবহারকারীর অগ্রগতি কখনো এই public repo-তে দিও না।
- কপিরাইট অনুমতি না থাকলে সম্পূর্ণ PDF আপলোড কোরো না; শুধু বইয়ের বিবরণ ও বৈধ প্রকাশক/পাঠের লিংক রাখো।

## স্কিমা

সব ফাইলের ফিল্ড বিবরণ দেখো: [CONTENT_SCHEMA.md](CONTENT_SCHEMA.md)
