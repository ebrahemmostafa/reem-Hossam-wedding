-- ====================================================================
-- سكربت إنشاء قاعدة بيانات المدعوين (RSVP) لزفاف حسام الدين وريم
-- ====================================================================

-- 1. إنشاء جدول المدعوين (guests)
CREATE TABLE IF NOT EXISTS public.guests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    phone TEXT,
    attendance TEXT DEFAULT 'yes',
    guest_count INTEGER DEFAULT 1,
    dietary_requirements TEXT,
    message TEXT,
    invite_code TEXT,
    accommodation TEXT,
    needs_transport BOOLEAN DEFAULT false,
    song_request TEXT,
    companions JSONB DEFAULT '[]'::jsonb,
    responded_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. تفعيل Row Level Security (RLS)
ALTER TABLE public.guests ENABLE ROW LEVEL SECURITY;

-- 3. السماح لزوار الموقع بتسجيل الحضور (INSERT)
CREATE POLICY "Allow public insert to guests"
ON public.guests FOR INSERT
TO anon
WITH CHECK (true);

-- 4. السماح للوحة التحكم بقراءة قائمة المدعوين (SELECT)
CREATE POLICY "Allow public select from guests"
ON public.guests FOR SELECT
TO anon
USING (true);

-- 5. السماح للوحة التحكم بمسح الردود التجريبية (DELETE)
CREATE POLICY "Allow public delete guests"
ON public.guests FOR DELETE
TO anon
USING (true);

-- 6. السماح بتعديل الردود عند الحاجة (UPDATE)
CREATE POLICY "Allow public update guests"
ON public.guests FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);
