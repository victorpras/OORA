from django.contrib import admin
from djangoblog.blog.models import Entry
from djangoblog.blog.admin import EntryAdmin

class AdminSite(admin.AdminSite):
    pass

site = AdminSite()
site.register(Entry, EntryAdmin)
