---
title: যোগাযোগ
permalink: "/contact.html"
---

<form action="https://formspree.io/{{site.email}}" method="POST" class="d-flex flex-column" style="gap: 16px">    
<p class="mb-4">আপনার কিছু বলার থাকলে এখানে লিখুন, আমি যত দ্রুত সম্ভব আপনার সাথে যোগাযোগ করব।</p>
<div class="form-group row">
<div class="col-md-6">
<input class="form-control" type="text" name="name" placeholder="নাম*" required>
</div>
<div class="col-md-6">
<input class="form-control" type="email" name="_replyto" placeholder="ইমেইল অ্যাড্রেস*" required>
</div>
</div>
<textarea rows="8" class="form-control mb-3" name="message" placeholder="বার্তা*" required></textarea>    
<input class="btn btn-success" style="width: fit-content;" type="submit" value="পাঠান">
</form>
