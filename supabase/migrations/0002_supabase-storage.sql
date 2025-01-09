-- Create public bucket for avatars
DELETE FROM storage.objects WHERE bucket_id = 'avatars';
DELETE FROM storage.buckets WHERE id = 'avatars';

INSERT INTO storage.buckets (id, name, public) 
VALUES ('avatars', 'avatars', true);

CREATE POLICY "Users can upload avatar image"
ON storage.objects FOR INSERT 
TO authenticated
WITH CHECK (
  bucket_id = 'avatars'
);

CREATE POLICY "Users can get their own avatar image"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'avatars' AND
  (auth.uid())::text = owner::text
);

CREATE POLICY "Users can update their own avatar image"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars' AND
  (auth.uid())::text = owner::text
);

CREATE POLICY "Users can delete their own avatar image"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars' AND
  (auth.uid())::text = owner::text
);